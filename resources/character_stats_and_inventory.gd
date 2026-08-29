class_name StatsAndInventory
extends Resource

@export var quests: Array[Quest] = [
	load("res://resources/quests/00_carrots.tres").duplicate(true),
	load("res://resources/quests/01_stew.tres").duplicate(true),
]

@export var last_quest_fulfilled_timestamp: int = -1

func set_quest_to_active(name: QuestConstants.Name):
	for quest in quests:
		if quest.real_name != name:
			continue
		quest.active = true
		quest.available = false
		for seed_type in quest.supplies_seeds:
			inventory.seed[seed_type.vegetable] += seed_type.count

func quest_can_be_completed(name: QuestConstants.Name):
	for quest in quests:
		if quest.real_name != name:
			continue
		pass

func mark_next_quest_available():
	var completed = []
	for quest in quests:
		if quest.active or quest.available:
			continue

		if quest.completed:
			completed.push_back(quest.real_name)
			continue

		var current_quest_ready = true
		for req in quest.prerequisite:
			if not completed.has(req):
				current_quest_ready = false
	
		quest.available = current_quest_ready
	last_quest_fulfilled_timestamp = -1

func get_current_quests():
	var current_quests = quests.filter(
		func filter_current_quests(quest: Quest):
			# check quest stats
			return quest.active
	)
	return current_quests

func get_next_quest():
	var possible_quests = quests.filter(
		func filter_possible_quests(quest: Quest):
			return quest.available
	)

	if possible_quests.size() > 0:
		return possible_quests[0]

	return null


@export var inventory: Inventory = Inventory.new()

@export var box_inventory: Inventory = Inventory.new()

@export var gold: int = 0

func _is_quest_fulfilled(quest: Quest):
	for requirement in quest.required_vegetables:
		if box_inventory.vegetable[requirement.vegetable] < requirement.count:
			return false
	for requirement in quest.required_fruit:
		if box_inventory.fruit[requirement.fruit] < requirement.count:
			return false
	for requirement in quest.required_consumables:
		if box_inventory.consumable[requirement.consumable] < requirement.count:
			return false
	return true

func can_fulfill_quest():
	for quest: Quest in get_current_quests():
		if _is_quest_fulfilled(quest):
			return true
	return false

func fulfill_current_quest():
	for quest: Quest in get_current_quests():
		if not _is_quest_fulfilled(quest):
			continue
		
		var new_gold = QuestConstants.REWARD[quest.real_name].gold
		
		gold = gold + new_gold
		for seed_reward in QuestConstants.REWARD[quest.real_name].seeds:
			inventory.seed[seed_reward.vegetable] = inventory.seed[seed_reward.vegetable] + seed_reward.count
		
		if QuestConstants.REWARD[quest.real_name].tool.size(): # TODO
			if QuestConstants.REWARD[quest.real_name].tool[0] == Constants.TOOL_TYPE.Hoe:
				has_hoe = true
			if QuestConstants.REWARD[quest.real_name].tool[0] == Constants.TOOL_TYPE.Axe:
				has_axe = true
			if QuestConstants.REWARD[quest.real_name].tool[0] == Constants.TOOL_TYPE.FishingRod:
				has_fishing_rod = true
		
		quest.active = false
		quest.completed = true

		box_inventory = Inventory.new()
		last_quest_fulfilled_timestamp = int(Time.get_unix_time_from_system())
		return quest.name
	return null



@export var water_level_max: int = 8
@export var water_level: int = 8
@export var has_watering_can = true #false
@export var has_hoe = false
@export var has_axe = true #false
@export var has_fishing_rod = false

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

func to_dict():
	return {
		"quests": quests.map(
			func _quest_to_dict(q: Quest): return q.to_dict()
		), #: Array[Quest]
		"inventory": inventory.to_dict(), #: Inventory = Inventory.new()
		"box_inventory": box_inventory.to_dict(), #: Inventory = Inventory.new()
		"gold": gold, # = 0
		"last_quest_fulfilled_timestamp": last_quest_fulfilled_timestamp, #: int
		"water_level_max": water_level_max, # = 8
		"water_level": water_level, # = 8
		"has_watering_can": has_watering_can, # = true #false
		"has_hoe": has_hoe, # = false
		"has_axe": has_axe, # = false
	}

static func from_dict(dict: Dictionary):
	var s = StatsAndInventory.new()
	s.quests = Array(
		dict['quests'].map(
			func _dict_to_quest(qd: Dictionary): return Quest.from_dict(qd)
		),
		TYPE_OBJECT, "Resource", Quest
	)
	s.inventory = Inventory.from_dict(dict['inventory'])
	s.box_inventory = Inventory.from_dict(dict['box_inventory'])
	
	s.gold = dict['gold']
	s.last_quest_fulfilled_timestamp = dict['last_quest_fulfilled_timestamp']
	s.water_level_max = dict['water_level_max']
	s.water_level = dict['water_level']
	s.has_watering_can = dict['has_watering_can']
	s.has_hoe = dict['has_hoe']
	s.has_axe = dict['has_axe']

	return s
	
