class_name StatsAndInventory
extends Resource

@export var quests: Array[Quest] = [
	load("res://resources/quests/00_carrots.tres").duplicate(true)
]

func set_quest_to_active(name: QuestConstants.Name):
	for quest in quests:
		if quest.real_name == name:
			quest.active = true
			for seed_type in quest.supplies_seeds:
				inventory.seed[seed_type.vegetable] += seed_type.count
		

func get_current_quests():
	var current_quests = quests.filter(
		func filter_current_quests(quest: Quest):
			# check quest stats
			return quest.active
	)
	return current_quests

func get_next_quest():
	var possible_quests = quests.filter(
		func filter_possible_quests(_quest):
			# check quest stats
			return true
	)
	if possible_quests.size() > 0:
		return possible_quests[0]
	
	return null


@export var inventory: Inventory = Inventory.new()

@export var box_inventory: Inventory = Inventory.new()

@export var water_level_max = 8
@export var water_level = 8
@export var has_watering_can = true #false
@export var has_hoe = false
@export var has_axe = false

func add_fruit_to_box(fruit_type: Constants.FRUIT_TYPE, amount: int):
	if inventory.fruit[fruit_type] == 0:
		return
	inventory.fruit[fruit_type] -= amount
	box_inventory.fruit[fruit_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_fruit_from_box(fruit_type: Constants.FRUIT_TYPE, amount: int):
	if box_inventory.fruit[fruit_type] == 0:
		return
	inventory.fruit[fruit_type] += amount
	box_inventory.fruit[fruit_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func add_vegetable_to_box(vegetable_type: Constants.VEGETABLE_TYPE, amount: int):
	if inventory.vegetable[vegetable_type] == 0:
		return
	inventory.vegetable[vegetable_type] -= amount
	box_inventory.vegetable[vegetable_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_vegetable_from_box(vegetable_type: Constants.VEGETABLE_TYPE, amount: int):
	if box_inventory.vegetable[vegetable_type] == 0:
		return
	inventory.vegetable[vegetable_type] += amount
	box_inventory.vegetable[vegetable_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func add_seeds_to_box(seeds_type: Constants.VEGETABLE_TYPE, amount: int):
	if inventory.seed[seeds_type] == 0:
		return
	inventory.seed[seeds_type] -= amount
	box_inventory.seeds[seeds_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_seeds_from_box(seeds_type: Constants.VEGETABLE_TYPE, amount: int):
	if box_inventory.seeds[seeds_type] == 0:
		return
	inventory.seed[seeds_type] += amount
	box_inventory.seeds[seeds_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func empty_box():
	for seed_type in Constants.VEGETABLE_TYPE:
		box_inventory.seeds[seed_type] = 0

	for fruit_type in Constants.FRUIT_TYPE:
		box_inventory.fruit[fruit_type] = 0

	for vegetable_type in Constants.VEGETABLE_TYPE:
		box_inventory.vegetable[vegetable_type] = 0

	Events.refresh_stats_and_inventory.emit(self)


func convert_vegetable_to_seeds(vegetable_type: Constants.VEGETABLE_TYPE):
	if inventory.vegetable[vegetable_type] == 0:
		return

	var harvest_range = Constants.SEED_YIELD_RANGES_BY_VEGETABLE_TYPE[vegetable_type]
	var harvest_yield = Dice.roll_d_range(harvest_range[0], harvest_range[1])
	
	inventory.vegetable[vegetable_type] -= 1
	inventory.seed[vegetable_type] += harvest_yield
	Events.refresh_stats_and_inventory.emit(self)
