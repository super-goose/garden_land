@icon("res://meta/assets/map.png")
extends Node2D

@export var starting_position = Vector2i(30, 30)
@export var dawn_dusk_duration = 10

@export_category('Level generation')
@export var generate_random_map = true
@export var world_width = 60
@export var world_height = 100
@export var hill_coefficient = 70


var map_generated = false

const SAVE_PATH := "user://garden_data.tres"

var garden_data: GardenData = null


func _ready():
	if ResourceLoader.exists(SAVE_PATH):
		garden_data = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		garden_data = GardenData.new()
		garden_data.dirt_tiles = $Dirt.get_used_cells()

	if generate_random_map:
		generate_said_random_map()
	else:
		LevelUtil.plantable_tiles = garden_data.dirt_tiles
		on_plantable_tiles_modified()
	LevelUtil.plantable_tiles_modified.connect(on_plantable_tiles_modified)
	Events.become_day.connect(become_day)
	Events.become_night.connect(become_night)
	Events.start_raining.connect(start_raining)
	Events.stop_raining.connect(stop_raining)
	Events.darken_for_bedtime.connect(darken_for_bedtime)

func start_raining():
	var c = Common.get_color(85, 87, 147, 255)
	var cc = $DarkLight.color
	$DarkLight.color = c
	$DarkLight.enabled = true
	var t = get_tree().create_tween()
	t.tween_property($DarkLight, 'energy', 1.7, 2)
	t.parallel().tween_property($Lamp, 'energy', 0.7, 2)

func stop_raining():
	var c = Common.get_color(85, 87, 147, 255)
	$DarkLight.color = c
	var t = get_tree().create_tween()
	t.tween_property($DarkLight, 'energy', 0, 2).call_deferred('disable_darklight')
	t.parallel().tween_property($Lamp, 'energy', 0, 2)

func disable_darklight():
	$DarkLight.enabled = false

func become_day():
	var c = Common.get_color(255, 255, 255, 255)
	$DarkLight.color = c
	var t = get_tree().create_tween()
	t.tween_property($DarkLight, 'energy', 0, dawn_dusk_duration).call_deferred('disable_darklight')
	t.parallel().tween_property($Lamp, 'energy', 0, dawn_dusk_duration)

func become_night():
	var c = Common.get_color(255, 255, 255, 255)
	$DarkLight.color = c
	$DarkLight.enabled = true
	var t = get_tree().create_tween()
	t.tween_property($DarkLight, 'energy', 0.7, dawn_dusk_duration)
	t.parallel().tween_property($Lamp, 'energy', 0.7, dawn_dusk_duration)

func darken_for_bedtime():
	var c = Common.get_color(255, 255, 255, 255)
	$DarkLight.color = c
	$DarkLight.enabled = true
	var t = get_tree().create_tween()
	t.tween_property($DarkLight, 'energy', 1, 1)
	t.tween_property($DarkLight, 'energy', 0, 1)
	t.tween_callback(
		func ():
			disable_darklight()
			Events.start_new_day.emit()
			Events.increase_hour.emit()
	)

func set_up_a_star_data():
	LevelUtil.set_up_a_star([
		# in preference order, ascending
		$StructuresFloor.get_used_cells(),
		$Path.get_used_cells(),
		$Grass.get_used_cells(),
		$Dirt.get_used_cells(),
	], Common.union([
		$RocksAndStuff.get_used_cells(),
		$Hill.get_used_cells(),
		$HillBushes.get_used_cells(),
		$Structures.get_used_cells(),
	]))

func set_hoeable_tiles():
	var not_grass = Common.union([
		$HillBushes.get_used_cells(),
		$Dirt.get_used_cells(),
		$Path.get_used_cells(),
		$RocksAndStuff.get_used_cells(),
		$StructuresFloor.get_used_cells(),
	])
	var hoeable_grass = $Grass.get_used_cells().filter(
		func hoeable_grass_filter(cell):
			return cell not in not_grass
	)
	LevelUtil.hoeable_tiles = hoeable_grass

var added_this_load: Array[Vector2] = []

func on_plantable_tiles_modified(dirt_cell = null):
	if dirt_cell:
		LevelUtil.plantable_tiles.push_back(dirt_cell)

	$Dirt.set_cells_terrain_connect(LevelUtil.plantable_tiles, 0, 1)
	
	if dirt_cell:
		garden_data.dirt_tiles = LevelUtil.plantable_tiles
		ResourceSaver.save(garden_data, SAVE_PATH)
	
	for tile_coord in LevelUtil.plantable_tiles:
		if (
			not $Dirt.get_cell_tile_data(tile_coord + Vector2i.DOWN)
			or not $Dirt.get_cell_tile_data(tile_coord + Vector2i.LEFT)
			or not $Dirt.get_cell_tile_data(tile_coord + Vector2i.RIGHT)
		):
			continue
		var coord_key = "%s,%s" % [tile_coord.x, tile_coord.y]

		# if we have already added this to the current loadout level, don't do anything
		# we are done with this part
		if added_this_load.has(coord_key):
			continue

		
		if garden_data.plot_states.has(coord_key): # exists
			# add this plot to the current loadout state
			continue

#breakp;oint do stuff heree
		#var new_plot_state = GardenPlotState.new()
		#new_plot_state.coordinates = tile_coord
		#
		#garden_data.plot_states[coord_key] = new_plot_state
		if not $Plot.get_cell_tile_data(tile_coord):
			$Plot.set_cell(tile_coord, 10, Vector2i.ZERO, 2)
			

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
				$Water.set_cell(Vector2i(x, y), 2, Vector2i(3 , 0))
			else:
				$Water.set_cell(Vector2i(x, y), 2, Vector2i(Dice.rng.randi_range(0, 2) , 0))

	# fills the tilemap grass and hill layers with grass and hill-bushes
	$Grass.set_cells_terrain_connect(LevelGenerationUtil.grass_terrain_array, 0, 0)
	$HillBushes.set_cells_terrain_connect(LevelGenerationUtil.hill_terrain_array, 0, 2)

	for tree_location in LevelGenerationUtil.tree_locations:
		$Dirt.set_cell(tree_location, 11, Vector2i.ZERO, 1)

	map_generated = true


func get_start_position() -> Vector2i:
	if not map_generated:
		return starting_position
#		generate_said_random_map()
	return LevelGenerationUtil.walkable_tiles[Dice.roll_dn(LevelGenerationUtil.walkable_tiles.size()) - 1]
#	return Vector2i.ZERO
	
