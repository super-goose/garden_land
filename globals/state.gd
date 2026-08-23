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

const MASTER_SAVE_PATH := "user://game_state.tres"


func _ready():
	print('state is ready')
	# TODO: when we get us a load file screen, this next call will not be in _ready()
	load_save_file() # this one right here # # # # # # # # # # # # # # #
	# here's the one # # # # # # # # # # # # # # # # # # # # # # # # # #

func _inventory_to_dict(inventory: Inventory):
	var seed_ = {}
	var vegetable = {}
	for v_type in Constants.VEGETABLE_TYPE:
		seed_[v_type] = inventory.seed[Constants.VEGETABLE_TYPE[v_type]]
		vegetable[v_type] = inventory.vegetable[Constants.VEGETABLE_TYPE[v_type]]

	var fruit = {}
	for f_type in Constants.FRUIT_TYPE:
		fruit[f_type] = inventory.fruit[Constants.FRUIT_TYPE[f_type]]

	var consumable = {}
	for c_type in Constants.CONSUMABLE_TYPE:
		consumable[c_type] = inventory.consumable[Constants.CONSUMABLE_TYPE[c_type]]

func _quest_to_dict(quest: Quest):
	var inv_veg_to_dict = func inv_seed_to_dict(iiv: InventoryItemVegetable):
		return {
			"vegetable": iiv.vegetable,
			"count": iiv.count,
		}
	var inv_fruit_to_dict = func inv_seed_to_dict(iif: InventoryItemFruit):
		return {
			"fruit": iif.fruit,
			"count": iif.count,
		}
	var inv_consumable_to_dict = func inv_seed_to_dict(iic: InventoryItemConsumable):
		return {
			"consumable": iic.consumable,
			"count": iic.count,
		}

	return {
		"name": quest.name, #: String
		"real_name": quest.real_name, #: QuestConstants.Name
		"prerequisite": quest.prerequisite, #: Array[QuestConstants.Name] = []
		"blurb": quest.blurb, #: String
		"note": quest.note, #: String
		"supplies_seeds": quest.supplies_seeds.map(inv_veg_to_dict), #: Array[InventoryItemVegetable]
		"supplies_equipment": quest.supplies_equipment, #: Array[Constants.TOOL_TYPE]
		"required_vegetables": quest.required_vegetables.map(inv_veg_to_dict), #: Array[InventoryItemVegetable]
		"required_fruit": quest.required_fruit.map(inv_fruit_to_dict), #: Array[InventoryItemFruit]
		"required_consumables": quest.required_consumables.map(inv_consumable_to_dict), #: Array[InventoryItemConsumable]
		"reward": {
			"gold": quest.reward.gold, #: int
			"seeds": quest.reward.seeds.map(inv_veg_to_dict), #: Array[InventoryItemVegetable]
			"tool": quest.reward.tool, #: Constants.TOOL_TYPE
		}, #: Reward 
		"available": quest.available, #: bool
		"active": quest.active, #: bool
		"has_read": quest.has_read, #: bool
		"completed": quest.completed, #: bool
	}



func state_to_dict():
	return {
		"stats_and_inventory": {
			"quests": stats_and_inventory.quests.map(_quest_to_dict), #: Array[Quest]
			"inventory": _inventory_to_dict(stats_and_inventory.inventory), #: Inventory = Inventory.new()
			"box_inventory": _inventory_to_dict(stats_and_inventory.box_inventory), #: Inventory = Inventory.new()
			"gold": stats_and_inventory.gold, # = 0
			"last_quest_fulfilled_timestamp": stats_and_inventory.last_quest_fulfilled_timestamp, #: int
			"water_level_max": stats_and_inventory.water_level_max, # = 8
			"water_level": stats_and_inventory.water_level, # = 8
			"has_watering_can": stats_and_inventory.has_watering_can, # = true #false
			"has_hoe": stats_and_inventory.has_hoe, # = false
			"has_axe": stats_and_inventory.has_axe, # = false
		},
		"garden_data": {
			"dirt_tiles": garden_data.dirt_tiles, #: Array[Vector2i]
			"plot_states": garden_data.plot_states, #: Dictionary = {}
			"start_location": garden_data.start_location, #: Vector2i
		},
	}

func dict_to_state():
	pass



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
