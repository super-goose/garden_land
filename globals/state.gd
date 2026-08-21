# class_name State
extends Node



const LEVEL_SAVE_PATH := "user://garden_data.tres"
var use_level_save_file = true
var level_needs_populated = false
var garden_data: GardenData

const CHARACTER_SAVE_PATH := "user://stats_and_inventory_8-9-2.tres"
var use_character_save_file = true
var character_needs_populated = false
var stats_and_inventory: StatsAndInventory



func _ready():
	print('state is ready')
	# TODO: when we get us a load file screen, this next call will not be in _ready()
	load_save_file()

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
	ResourceSaver.save(garden_data, LEVEL_SAVE_PATH)
	ResourceSaver.save(stats_and_inventory, CHARACTER_SAVE_PATH)
