@icon("res://modified-assets/ui/menu_button.png")
extends Control

enum PROCESS_MENU_TYPE {
	Vegetable_Item,
	Fruit_Item,
	Seed_Item,
	Tool_Item,
}

@onready var menu_header = $MarginContainer/VBoxContainer/MenuHeader
@onready var tab_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer
@onready var process_menu = $ProcessMenu

@onready var inv_seeds_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/SeedsSection
@onready var inv_consumable_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/ConsumableSection
@onready var inv_plant_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/VegetablesSection
@onready var inv_fruit_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/FruitSection
@onready var inv_tools_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/ToolsSection
@onready var inv_box_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/BoxSection

@onready var ws_seeds_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/SeedsSection
@onready var ws_consumable_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/ConsumableSection
@onready var ws_plant_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/VegetablesSection
@onready var ws_fruit_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/FruitSection
@onready var ws_tools_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/ToolsSection
@onready var ws_box_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/MarginContainer/VBoxContainer/BoxSection

@onready var inv_money_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Label
@onready var dev_utils_menu = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Dev/DevUtilsMenu

var ConsumableCellScene = load("res://scenes/consumable_cell.tscn")
var FruitCellScene = load("res://scenes/fruit_cell.tscn")
var VegetableCellScene = load("res://scenes/vegetable_cell.tscn")
var ToolCellScene = load("res://scenes/tool_cell.tscn")
var SeedsCellScene = load("res://scenes/seeds_cell.tscn")
var QuestSummaryScene = load("res://scenes/ui_components/quest_summary.tscn")

var is_workstation_menu = false

func _ready():
	menu_header.close_button_pressed.connect(_on_close_button_pressed)
	menu_header.settings_button_pressed.connect(_on_settings_button_pressed)
	Events.open_menu.connect(open_menu)

func open_process_vegetable_menu(vegetable: Constants.VEGETABLE_TYPE, stats: StatsAndInventory):
	process_menu.open()
	process_menu.add_item({
		'words': 'harvest seeds',
		'type': 'button',
		'functionality': func veg_functionality_harvest():
			stats.convert_vegetable_to_seeds(vegetable)
			process_menu.close()
	})
	process_menu.add_item({
		'words': 'add vegetable to box',
		'type': 'button',
		'functionality': func veg_functionality_add():

			process_menu.clear_items()
			process_menu.add_item({
				'type': 'slider',
				'max_value': stats.inventory.vegetable[vegetable],
				'functionality': func veg_functionality_select(amount):
					stats.add_vegetable_to_box(vegetable, amount)
					process_menu.close(),
				'cancel': func veg_functionality_close():
					open_process_vegetable_menu(vegetable, stats)
			})
	})

func open_process_fruit_menu(fruit: Constants.FRUIT_TYPE, stats: StatsAndInventory):
	process_menu.open()
	#process_menu.add_item({
		#'words': 'add fruit to box',
		#'type': 'button',
		#'functionality': func veg_functionality():
			#stats.add_fruit_to_box(fruit, 1)
			#process_menu.close()
	#})
	process_menu.add_item({
		'words': 'add fruit to box',
		'type': 'button',
		'functionality': func fruit_functionality_add():
			process_menu.clear_items()
			process_menu.add_item({
				'type': 'slider',
				'max_value': stats.inventory.fruit[fruit],
				'functionality': func veg_functionality_select(amount):
					stats.add_fruit_to_box(fruit, amount)
					process_menu.close(),
				'cancel': func veg_functionality_close():
					open_process_fruit_menu(fruit, stats)
			})

			#stats.add_fruit_to_box(fruit, 1)
			#process_menu.close()
	})

func open_process_seeds_menu(seeds: Constants.VEGETABLE_TYPE, stats: StatsAndInventory):
	process_menu.open()
	process_menu.add_item({
		'words': 'add seeds to box',
		'type': 'button',
		'functionality': func veg_functionality():
			stats.add_seeds_to_box(seeds, 1)
			process_menu.close()
	})

func populate_workstation_tab():
	var consumable_inventory = []
	for consumable in State.stats_and_inventory.inventory.consumable:
		if State.stats_and_inventory.inventory.consumable[consumable] == 0:
			continue
		var consumable_cell = ConsumableCellScene.instantiate()
		consumable_cell.set_data(consumable, State.stats_and_inventory.inventory.consumable[consumable])
		consumable_inventory.push_back(consumable_cell)

	var vegetable_inventory = []
	for vegetable in State.stats_and_inventory.inventory.vegetable:
		if State.stats_and_inventory.inventory.vegetable[vegetable] == 0:
			continue
		var vegetable_cell = VegetableCellScene.instantiate()
		vegetable_cell.set_data(vegetable, State.stats_and_inventory.inventory.vegetable[vegetable])
		vegetable_cell.set_functionality(
			func __open_process_vegetable_menu():
				open_process_vegetable_menu(vegetable, State.stats_and_inventory)
		)
		vegetable_inventory.push_back(vegetable_cell)

	var fruit_inventory = []
	for fruit in State.stats_and_inventory.inventory.fruit:
		if State.stats_and_inventory.inventory.fruit[fruit] == 0:
			continue
		var fruit_cell = FruitCellScene.instantiate()
		fruit_cell.set_data(fruit, State.stats_and_inventory.inventory.fruit[fruit])
		fruit_cell.set_functionality(
			func __open_process_fruit_menu():
				open_process_fruit_menu(fruit, State.stats_and_inventory)
		)
		fruit_inventory.push_back(fruit_cell)

	var tools_inventory = []
	var water_can_cell = ToolCellScene.instantiate()
	water_can_cell.set_data(Constants.TOOL_TYPE.WateringCan, "%s/%s"%[State.stats_and_inventory.water_level, State.stats_and_inventory.water_level_max])
	tools_inventory.push_back(water_can_cell)

	if State.stats_and_inventory.has_axe:
		var axe_cell = ToolCellScene.instantiate()
		axe_cell.set_data(Constants.TOOL_TYPE.Axe, "")
		tools_inventory.push_back(axe_cell)

	if State.stats_and_inventory.has_hoe:
		var hoe_cell = ToolCellScene.instantiate()
		hoe_cell.set_data(Constants.TOOL_TYPE.Hoe, "")
		tools_inventory.push_back(hoe_cell)

	var seeds_inventory = []
	for seeds in State.stats_and_inventory.inventory.seed:
		if State.stats_and_inventory.inventory.seed[seeds] == 0:
			continue
		var seeds_cell = SeedsCellScene.instantiate()
		seeds_cell.set_functionality(
			func __open_process_seeds_menu():
				open_process_seeds_menu(seeds, State.stats_and_inventory)
		)
		seeds_cell.set_data(seeds, State.stats_and_inventory.inventory.seed[seeds])
		seeds_inventory.push_back(seeds_cell)

	var box_inventory = []
	for seeds in State.stats_and_inventory.box_inventory.seed:
		if State.stats_and_inventory.box_inventory.seed[seeds] == 0:
			continue
		var seeds_cell = SeedsCellScene.instantiate()
		seeds_cell.set_data(seeds, State.stats_and_inventory.box_inventory.seed[seeds])
		box_inventory.push_back(seeds_cell)

	for fruit in State.stats_and_inventory.box_inventory.fruit:
		if State.stats_and_inventory.box_inventory.fruit[fruit] == 0:
			continue
		var fruit_cell = FruitCellScene.instantiate()
		fruit_cell.set_data(fruit, State.stats_and_inventory.box_inventory.fruit[fruit])
		box_inventory.push_back(fruit_cell)

	for vegetable in State.stats_and_inventory.box_inventory.vegetable:
		if State.stats_and_inventory.box_inventory.vegetable[vegetable] == 0:
			continue
		var vegetable_cell = VegetableCellScene.instantiate()
		vegetable_cell.set_data(vegetable, State.stats_and_inventory.box_inventory.vegetable[vegetable])
		box_inventory.push_back(vegetable_cell)

	ws_seeds_grid_container.set_items(seeds_inventory)
	ws_consumable_grid_container.set_items(consumable_inventory)
	ws_plant_grid_container.set_items(vegetable_inventory)
	ws_fruit_grid_container.set_items(fruit_inventory)
	ws_tools_grid_container.set_items(tools_inventory)
	ws_box_grid_container.set_items(box_inventory)


func populate_inventory_tab():
	var consumable_inventory = []
	for consumable in State.stats_and_inventory.inventory.consumable:
		if State.stats_and_inventory.inventory.consumable[consumable] == 0:
			continue
		var consumable_cell = ConsumableCellScene.instantiate()
		consumable_cell.set_data(consumable, State.stats_and_inventory.inventory.consumable[consumable])
		consumable_inventory.push_back(consumable_cell)

	var fruit_inventory = []
	for fruit in State.stats_and_inventory.inventory.fruit:
		if State.stats_and_inventory.inventory.fruit[fruit] == 0:
			continue
		var fruit_cell = FruitCellScene.instantiate()
		fruit_cell.set_data(fruit, State.stats_and_inventory.inventory.fruit[fruit])
		fruit_inventory.push_back(fruit_cell)

	var plant_inventory = []
	for plant in State.stats_and_inventory.inventory.vegetable:
		if State.stats_and_inventory.inventory.vegetable[plant] == 0:
			continue
		var plant_cell = VegetableCellScene.instantiate()
		plant_cell.set_data(plant, State.stats_and_inventory.inventory.vegetable[plant])
		plant_inventory.push_back(plant_cell)

	var tools_inventory = []
	var water_can_cell = ToolCellScene.instantiate()
	water_can_cell.set_data(Constants.TOOL_TYPE.WateringCan, "%s/%s" % [
		State.stats_and_inventory.water_level,
		State.stats_and_inventory.water_level_max,
	])
	tools_inventory.push_back(water_can_cell)
	
	if State.stats_and_inventory.has_axe:
		var axe_cell = ToolCellScene.instantiate()
		axe_cell.set_data(Constants.TOOL_TYPE.Axe, "")
		tools_inventory.push_back(axe_cell)

	if State.stats_and_inventory.has_hoe:
		var hoe_cell = ToolCellScene.instantiate()
		hoe_cell.set_data(Constants.TOOL_TYPE.Hoe, "")
		tools_inventory.push_back(hoe_cell)

	var seeds_inventory = []
	for seeds in State.stats_and_inventory.inventory.seed:
		if State.stats_and_inventory.inventory.seed[seeds] == 0:
			continue
		var seeds_cell = SeedsCellScene.instantiate()
		seeds_cell.set_data(seeds, State.stats_and_inventory.inventory.seed[seeds])
		seeds_inventory.push_back(seeds_cell)

	var box_inventory = []
	for seeds in State.stats_and_inventory.box_inventory.seed:
		if State.stats_and_inventory.box_inventory.seed[seeds] == 0:
			continue
		var seeds_cell = SeedsCellScene.instantiate()
		seeds_cell.set_data(seeds, State.stats_and_inventory.box_inventory.seed[seeds])
		box_inventory.push_back(seeds_cell)

	for consumable in State.stats_and_inventory.box_inventory.consumable:
		if State.stats_and_inventory.box_inventory.consumable[consumable] == 0:
			continue
		var consumable_cell = ConsumableCellScene.instantiate()
		consumable_cell.set_data(consumable, State.stats_and_inventory.box_inventory.consumable[consumable])
		box_inventory.push_back(consumable_cell)

	for fruit in State.stats_and_inventory.box_inventory.fruit:
		if State.stats_and_inventory.box_inventory.fruit[fruit] == 0:
			continue
		var fruit_cell = FruitCellScene.instantiate()
		fruit_cell.set_data(fruit, State.stats_and_inventory.box_inventory.fruit[fruit])
		box_inventory.push_back(fruit_cell)

	for vegetable in State.stats_and_inventory.box_inventory.vegetable:
		if State.stats_and_inventory.box_inventory.vegetable[vegetable] == 0:
			continue
		var vegetable_cell = VegetableCellScene.instantiate()
		vegetable_cell.set_data(vegetable, State.stats_and_inventory.box_inventory.vegetable[vegetable])
		box_inventory.push_back(vegetable_cell)

	inv_seeds_grid_container.set_items(seeds_inventory)
	inv_consumable_grid_container.set_items(consumable_inventory)
	inv_plant_grid_container.set_items(plant_inventory)
	inv_fruit_grid_container.set_items(fruit_inventory)
	inv_tools_grid_container.set_items(tools_inventory)
	inv_box_grid_container.set_items(box_inventory)
	inv_money_container.text = str(State.stats_and_inventory.gold)

func populate_quest_tab():
	var quest_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Quests/MarginContainer/QuestVBoxContainer
	for child in quest_container.get_children():
		quest_container.remove_child(child)
	for quest in State.stats_and_inventory.get_current_quests():
		var qss = QuestSummaryScene.instantiate()
		qss.populate_quest(quest)
		quest_container.add_child(qss)

func open_menu(_stats: StatsAndInventory, is_workstation = false):
	Events.time_passage_pause.emit()
	# hide inventory tab when at workbench
	tab_container.set_tab_hidden(0, is_workstation)
	# hide workbench when not at workbench
	tab_container.set_tab_hidden(1, not is_workstation)
	tab_container.set_tab_hidden(4, not State.DEBUG_MODE)
	is_workstation_menu = is_workstation
	if is_workstation:
		tab_container.current_tab = 1
		populate_workstation_tab()
	visible = true
	populate_inventory_tab()
	populate_quest_tab()
	dev_utils_menu.refresh()
	Events.refresh_stats_and_inventory.connect(_handle_event_refresh_inventory)

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
	Events.time_passage_play.emit()
	Events.refresh_stats_and_inventory.disconnect(_handle_event_refresh_inventory)

func _on_settings_button_pressed():
	print('handle settings menu')

func _handle_event_refresh_inventory():
	populate_quest_tab()
	populate_inventory_tab()
	dev_utils_menu.refresh()
	if is_workstation_menu:
		populate_workstation_tab()
