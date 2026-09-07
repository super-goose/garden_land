# class_name State
extends Node

@warning_ignore("unused_signal")
signal reload_game

var DEBUG_MODE = false

#const WORLD_SAVE_PATH := "user://world_data.tres"
#var use_world_save_file = true
#var world_needs_processing = false
#var world_data: WorldData

const LEVEL_SAVE_PATH := "user://garden_data.tres"
var use_level_save_file = true
var level_needs_populated = false
var garden_data: GardenData

const CHARACTER_SAVE_PATH := "user://stats_and_inventory_8-9-2.tres"
var use_character_save_file = false #true
var character_needs_populated = false
var stats_and_inventory: StatsAndInventory

const WILD_GROWTH_SAVE_PATH := "user://wild_growth_state.tres"
var use_wild_growth_save_file = true
var wild_growth_state: WildGrowthState

const MASTER_SAVE_PATH := "user://game_state.tres"


func _ready():
	print('state is ready')
	# TODO: when we get us a load file screen, this next call will not be in _ready()
	load_save_file() # this one right here # # # # # # # # # # # # # # #
	# here's the one # # # # # # # # # # # # # # # # # # # # # # # # # #

func register_tree(tree_scene: FruitTree):
	var key = tree_scene.coordinates
	if wild_growth_state.trees.has(key):
		tree_scene.state = wild_growth_state.trees[key]
	else:
		var new_tree_state = FruitTreeState.new()
		new_tree_state.set_new_types()
		wild_growth_state.trees[key] = new_tree_state
		tree_scene.state = new_tree_state
	tree_scene.post_state_visual_update()

func update_tree(tree_scene: FruitTree):
	var key = tree_scene.coordinates
	wild_growth_state.trees[key] = tree_scene.state
	save_save_file()

func state_to_dict():
	return {
		"stats_and_inventory": stats_and_inventory.to_dict(),
		"garden_data": garden_data.to_dict(),
		"wild_growth_state": wild_growth_state.to_dict()
	}

func dict_to_state(dict: Dictionary):
	stats_and_inventory = StatsAndInventory.from_dict(dict['stats_and_inventory'])
	garden_data = GardenData.from_dict(dict['garden_data'])
	wild_growth_state = WildGrowthState.from_dict(dict['wild_growth_state'])
	
	reload_game.emit()
	



func load_save_file():
	## LOAD LEVEL
	if ResourceLoader.exists(LEVEL_SAVE_PATH) and use_level_save_file:
		garden_data = ResourceLoader.load(LEVEL_SAVE_PATH, "GardenData", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		garden_data = GardenData.new()
		level_needs_populated = true

	if ResourceLoader.exists(CHARACTER_SAVE_PATH) and use_character_save_file:
		stats_and_inventory = ResourceLoader.load(CHARACTER_SAVE_PATH, "StatsAndInventory", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		stats_and_inventory = StatsAndInventory.new()
		character_needs_populated = true

	if ResourceLoader.exists(WILD_GROWTH_SAVE_PATH) and use_wild_growth_save_file:
		wild_growth_state = ResourceLoader.load(WILD_GROWTH_SAVE_PATH, "WildGrowthState", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		wild_growth_state = WildGrowthState.new()
	#if ResourceLoader.exists(WORLD_SAVE_PATH) and use_world_save_file:
		#world_data = ResourceLoader.load(WORLD_SAVE_PATH, "WorldData", ResourceLoader.CACHE_MODE_IGNORE)
		#world_needs_processing = true
	#else:
		#world_data = WorldData.new()
		#world_needs_processing = false

func save_save_file():
	#print(state_to_dict())
	ResourceSaver.save(garden_data, LEVEL_SAVE_PATH)
	ResourceSaver.save(stats_and_inventory, CHARACTER_SAVE_PATH)
	ResourceSaver.save(wild_growth_state, WILD_GROWTH_SAVE_PATH)
