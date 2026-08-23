# class_name State
extends Node

@warning_ignore("unused_signal")
signal reload_game

const LEVEL_SAVE_PATH := "user://garden_data.tres"
var use_level_save_file = true
var level_needs_populated = false
var garden_data: GardenData

const CHARACTER_SAVE_PATH := "user://stats_and_inventory_8-9-2.tres"
var use_character_save_file = false
var character_needs_populated = false
var stats_and_inventory: StatsAndInventory

const MASTER_SAVE_PATH := "user://game_state.tres"


func _ready():
	print('state is ready')
	# TODO: when we get us a load file screen, this next call will not be in _ready()
	load_save_file() # this one right here # # # # # # # # # # # # # # #
	# here's the one # # # # # # # # # # # # # # # # # # # # # # # # # #



func state_to_dict():
	return {
		"stats_and_inventory": stats_and_inventory.to_dict(),
		"garden_data": garden_data.to_dict(),
	}

func dict_to_state(dict: Dictionary):
	stats_and_inventory = StatsAndInventory.from_dict(dict['stats_and_inventory'])
	garden_data = GardenData.from_dict(dict['garden_data'])
	reload_game.emit()
	



func load_save_file():
	## LOAD LEVEL
	if ResourceLoader.exists(LEVEL_SAVE_PATH) and use_level_save_file:
		garden_data = ResourceLoader.load(LEVEL_SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		garden_data = GardenData.new()
		level_needs_populated = true

	if ResourceLoader.exists(CHARACTER_SAVE_PATH) and use_character_save_file:
		stats_and_inventory = ResourceLoader.load(CHARACTER_SAVE_PATH, "StatsAndInventory", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		stats_and_inventory = StatsAndInventory.new()
		character_needs_populated = true


func save_save_file():
	#print(state_to_dict())
	ResourceSaver.save(garden_data, LEVEL_SAVE_PATH)
	ResourceSaver.save(stats_and_inventory, CHARACTER_SAVE_PATH)
