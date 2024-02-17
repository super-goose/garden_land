@icon("res://meta/assets/map.png")
extends Node2D

@export var starting_position = Vector2i(30, 30)
@export var dawn_dusk_duration = 10

@export_category('Level generation')
@export var generate_random_map = true
@export var world_width = 60
@export var world_height = 100
@export var hill_coefficient = 70


const LAYER_WATER = 0
const LAYER_GRASS = 1
const LAYER_DIRT = 2
const LAYER_ROCKS_AND_STUFF = 3
const LAYER_HILL = 4
const LAYER_PLOT = 5
const LAYER_HILL_BUSHES = 6
const LAYER_PATH = 7
const LAYER_STRUCTURE_FLOOR = 8
const LAYER_STRUCTURE = 9

var map_generated = false

func _ready():
	if generate_random_map:
		generate_said_random_map()
	else:
		LevelUtil.plantable_tiles = $TileMap2.get_used_cells(LAYER_DIRT)
		on_plantable_tiles_modified()
	LevelUtil.plantable_tiles_modified.connect(on_plantable_tiles_modified)
	Events.become_day.connect(become_day)
	Events.become_night.connect(become_night)
	Events.start_raining.connect(start_raining)
	Events.stop_raining.connect(stop_raining)

func start_raining():
	var t = get_tree().create_tween()
	t.tween_property($RainLight, 'energy', 1.7, 2)
	t.parallel().tween_property($Lamp, 'energy', 0.7, 2)

func stop_raining():
	var t = get_tree().create_tween()
	t.tween_property($RainLight, 'energy', 0, 2)
	t.parallel().tween_property($Lamp, 'energy', 0, 2)

func become_day():
	var t = get_tree().create_tween()
	t.tween_property($NightLight, 'energy', 0, dawn_dusk_duration)
	t.parallel().tween_property($Lamp, 'energy', 0, 2)

func become_night():
	var t = get_tree().create_tween()
	t.tween_property($NightLight, 'energy', 0.7, dawn_dusk_duration)
	t.parallel().tween_property($Lamp, 'energy', 0.7, 2)

func set_up_a_star_data():
	LevelUtil.set_up_a_star($TileMap2, [
		# in preference order, ascending
		LAYER_PATH,
		LAYER_GRASS,
		LAYER_DIRT,
		LAYER_STRUCTURE_FLOOR,
	], [
		LAYER_ROCKS_AND_STUFF,
		LAYER_HILL,
		LAYER_HILL_BUSHES,
		LAYER_STRUCTURE,

	])

func set_hoeable_tiles():
	var not_grass = Common.union([
		$TileMap2.get_used_cells(LAYER_HILL_BUSHES),
		$TileMap2.get_used_cells(LAYER_DIRT),
		$TileMap2.get_used_cells(LAYER_PATH),
		$TileMap2.get_used_cells(LAYER_ROCKS_AND_STUFF),
		$TileMap2.get_used_cells(LAYER_STRUCTURE_FLOOR),
	])
	var hoeable_grass = $TileMap2.get_used_cells(LAYER_GRASS).filter(
		func hoeable_grass_filter(cell):
			return cell not in not_grass
	)
	LevelUtil.hoeable_tiles = hoeable_grass

func on_plantable_tiles_modified(dirt_cell = null):
	if dirt_cell:
		LevelUtil.plantable_tiles.push_back(dirt_cell)
		$TileMap2.set_cells_terrain_connect(LAYER_DIRT, LevelUtil.plantable_tiles, 0, 1)

	$TileMap2.set_cells_terrain_connect(LAYER_DIRT, LevelUtil.plantable_tiles, 0, 1)
	for tile_coord in LevelUtil.plantable_tiles:
		if not $TileMap2.get_cell_tile_data(LAYER_PLOT, tile_coord):
			$TileMap2.set_cell(LAYER_PLOT, tile_coord, 10, Vector2i.ZERO, 2)

	set_up_a_star_data()
	set_hoeable_tiles()

func generate_said_random_map():
	# clears the tilemap
	$TileMap2.clear()
	LevelGenerationUtil.generate_map_matrix(world_width, world_height)

	# fills the tilemap water layer with water
	for x in range(0, world_width):
		for y in range(0, world_height):
			if LevelGenerationUtil.grass_terrain_array.find(Vector2i(x, y)) > -1:
				$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(3 , 0))
			else:
				$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(Dice.rng.randi_range(0, 2) , 0))

	# fills the tilemap grass and hill layers with grass and hill-bushes
	$TileMap2.set_cells_terrain_connect(LAYER_GRASS, LevelGenerationUtil.grass_terrain_array, 0, 0)
	$TileMap2.set_cells_terrain_connect(LAYER_HILL_BUSHES, LevelGenerationUtil.hill_terrain_array, 0, 2)

	for tree_location in LevelGenerationUtil.tree_locations:
		$TileMap2.set_cell(LAYER_DIRT, tree_location, 11, Vector2i.ZERO, 1)

	map_generated = true


func get_start_position() -> Vector2i:
	if not map_generated:
		return starting_position
#		generate_said_random_map()
	return LevelGenerationUtil.walkable_tiles[Dice.roll_dn(LevelGenerationUtil.walkable_tiles.size()) - 1]
#	return Vector2i.ZERO
	
