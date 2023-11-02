extends Node2D

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

var map_generated = false

func _ready():
	if generate_random_map:
		generate_said_random_map()
	LevelGenerationUtil.plantable_tiles_modified.connect(on_plantable_tiles_modified)

func on_plantable_tiles_modified():
	$TileMap2.set_cells_terrain_connect(LAYER_DIRT, LevelGenerationUtil.plantable_tiles, 0, 1)
	for tile_coord in LevelGenerationUtil.plantable_tiles:
		if not $TileMap2.get_cell_tile_data(LAYER_PLOT, tile_coord):
			$TileMap2.set_cell(LAYER_PLOT, tile_coord, 10, Vector2i.ZERO, 2)

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
		return Vector2i(3, -2)
#		generate_said_random_map()
	return LevelGenerationUtil.walkable_tiles[Dice.roll_dn(LevelGenerationUtil.walkable_tiles.size()) - 1]
#	return Vector2i.ZERO
	
