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

@onready var inv_seeds_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/VBoxContainer/SeedsSection
@onready var inv_plant_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/VBoxContainer/VegetablesSection
@onready var inv_fruit_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/VBoxContainer/FruitSection
@onready var inv_tools_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/VBoxContainer/ToolsSection
@onready var inv_box_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Inventory/VBoxContainer/BoxSection

@onready var ws_seeds_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/VBoxContainer/SeedsSection
@onready var ws_plant_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/VBoxContainer/VegetablesSection
@onready var ws_fruit_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/VBoxContainer/FruitSection
@onready var ws_tools_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/VBoxContainer/ToolsSection
@onready var ws_box_grid_container = $MarginContainer/VBoxContainer/ContentContainer/TabContainer/Workstation/VBoxContainer/BoxSection

var FruitCell = load("res://scenes/fruit_cell.tscn")
var VegetableCell = load("res://scenes/vegetable_cell.tscn")
var ToolCell = load("res://scenes/tool_cell.tscn")
var SeedsCell = load("res://scenes/seeds_cell.tscn")

var is_workstation_menu = false

# Called when the node enters the scene tree for the first time.
func _ready():
	menu_header.close_button_pressed.connect(_on_close_button_pressed)
	menu_header.settings_button_pressed.connect(_on_settings_button_pressed)
	Events.open_menu.connect(open_menu)

func open_process_vegetable_menu(vegetable: Constants.VEGETABLE_TYPE, stats: StatsAndInventory):
	process_menu.open()
	process_menu.add_item({
		'words': 'harvest seeds',
		'functionality': func veg_functionality():
			stats.convert_vegetable_to_seeds(vegetable)
			process_menu.close()
	})
	process_menu.add_item({
		'words': 'add vegetable to box',
		'functionality': func veg_functionality():
			stats.add_vegetable_to_box(vegetable, 1)
			process_menu.close()
	})

func open_process_fruit_menu(fruit: Constants.FRUIT_TYPE, stats: StatsAndInventory):
	process_menu.open()
	process_menu.add_item({
		'words': 'add fruit to box',
		'functionality': func veg_functionality():
			stats.add_fruit_to_box(fruit, 1)
			process_menu.close()
	})

func open_process_seeds_menu(seeds: Constants.VEGETABLE_TYPE, stats: StatsAndInventory):
	process_menu.open()
	process_menu.add_item({
		'words': 'add seeds to box',
		'functionality': func veg_functionality():
			stats.add_seeds_to_box(seeds, 1)
			process_menu.close()
	})

func populate_workstation_tab(stats: StatsAndInventory):
	var vegetable_inventory = []
	for vegetable in stats.vegetable_inventory:
		if stats.vegetable_inventory[vegetable] == 0:
			continue
		var vegetable_cell = VegetableCell.instantiate()
		vegetable_cell.set_data(vegetable, stats.vegetable_inventory[vegetable])
		vegetable_cell.set_functionality(
			func __open_process_vegetable_menu():
				open_process_vegetable_menu(vegetable, stats)
		)
		vegetable_inventory.push_back(vegetable_cell)
		

	var fruit_inventory = []
	for fruit in stats.fruit_inventory:
		if stats.fruit_inventory[fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.fruit_inventory[fruit])
		fruit_cell.set_functionality(
			func __open_process_fruit_menu():
				open_process_fruit_menu(fruit, stats)
		)
		fruit_inventory.push_back(fruit_cell)

	var tools_inventory = []
	var water_can_cell = ToolCell.instantiate()
	water_can_cell.set_data(Constants.TOOL_TYPE.WateringCan, "%s/%s"%[stats.water_level, stats.water_level_max])
	tools_inventory.push_back(water_can_cell)
	
	if stats.has_axe:
		var axe_cell = ToolCell.instantiate()
		axe_cell.set_data(Constants.TOOL_TYPE.Axe, "")
		tools_inventory.push_back(axe_cell)

	if stats.has_hoe:
		var hoe_cell = ToolCell.instantiate()
		hoe_cell.set_data(Constants.TOOL_TYPE.Hoe, "")
		tools_inventory.push_back(hoe_cell)

	var seeds_inventory = []
	for seeds in stats.seeds_inventory:
		if stats.seeds_inventory[seeds] == 0:
			continue
		var seeds_cell = SeedsCell.instantiate()
		seeds_cell.set_functionality(
			func __open_process_seeds_menu():
				open_process_seeds_menu(seeds, stats)
		)
		seeds_cell.set_data(seeds, stats.seeds_inventory[seeds])
		seeds_inventory.push_back(seeds_cell)

	var box_inventory = []
	for seeds in stats.box_inventory['seeds']:
		if stats.box_inventory['seeds'][seeds] == 0:
			continue
		var seeds_cell = SeedsCell.instantiate()
		seeds_cell.set_data(seeds, stats.box_inventory['seeds'][seeds])
		box_inventory.push_back(seeds_cell)

	for fruit in stats.box_inventory['fruit']:
		if stats.box_inventory['fruit'][fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.box_inventory['fruit'][fruit])
		box_inventory.push_back(fruit_cell)

	for vegetable in stats.box_inventory['vegetable']:
		if stats.box_inventory['vegetable'][vegetable] == 0:
			continue
		var vegetable_cell = VegetableCell.instantiate()
		vegetable_cell.set_data(vegetable, stats.box_inventory['vegetable'][vegetable])
		box_inventory.push_back(vegetable_cell)

	ws_seeds_grid_container.set_items(seeds_inventory)
	ws_plant_grid_container.set_items(vegetable_inventory)
	ws_fruit_grid_container.set_items(fruit_inventory)
	ws_tools_grid_container.set_items(tools_inventory)
	ws_box_grid_container.set_items(box_inventory)


func populate_inventory_tab(stats: StatsAndInventory):
	var plant_inventory = []
	for plant in stats.vegetable_inventory:
		if stats.vegetable_inventory[plant] == 0:
			continue
		var plant_cell = VegetableCell.instantiate()
		plant_cell.set_data(plant, stats.vegetable_inventory[plant])
		plant_inventory.push_back(plant_cell)

	var fruit_inventory = []
	for fruit in stats.fruit_inventory:
		if stats.fruit_inventory[fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.fruit_inventory[fruit])
		fruit_inventory.push_back(fruit_cell)

	var tools_inventory = []
	var water_can_cell = ToolCell.instantiate()
	water_can_cell.set_data(Constants.TOOL_TYPE.WateringCan, "%s/%s"%[stats.water_level, stats.water_level_max])
	tools_inventory.push_back(water_can_cell)
	
	if stats.has_axe:
		var axe_cell = ToolCell.instantiate()
		axe_cell.set_data(Constants.TOOL_TYPE.Axe, "")
		tools_inventory.push_back(axe_cell)

	if stats.has_hoe:
		var hoe_cell = ToolCell.instantiate()
		hoe_cell.set_data(Constants.TOOL_TYPE.Hoe, "")
		tools_inventory.push_back(hoe_cell)

	var seeds_inventory = []
	for seeds in stats.seeds_inventory:
		if stats.seeds_inventory[seeds] == 0:
			continue
		var seeds_cell = SeedsCell.instantiate()
		seeds_cell.set_data(seeds, stats.seeds_inventory[seeds])
		seeds_inventory.push_back(seeds_cell)

	var box_inventory = []
	for seeds in stats.box_inventory['seeds']:
		if stats.box_inventory['seeds'][seeds] == 0:
			continue
		var seeds_cell = SeedsCell.instantiate()
		seeds_cell.set_data(seeds, stats.box_inventory['seeds'][seeds])
		box_inventory.push_back(seeds_cell)

	for fruit in stats.box_inventory['fruit']:
		if stats.box_inventory['fruit'][fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.box_inventory['fruit'][fruit])
		box_inventory.push_back(fruit_cell)

	for vegetable in stats.box_inventory['vegetable']:
		if stats.box_inventory['vegetable'][vegetable] == 0:
			continue
		var vegetable_cell = VegetableCell.instantiate()
		vegetable_cell.set_data(vegetable, stats.box_inventory['vegetable'][vegetable])
		box_inventory.push_back(vegetable_cell)

	inv_seeds_grid_container.set_items(seeds_inventory)
	inv_plant_grid_container.set_items(plant_inventory)
	inv_fruit_grid_container.set_items(fruit_inventory)
	inv_tools_grid_container.set_items(tools_inventory)
	inv_box_grid_container.set_items(box_inventory)

func open_menu(stats: StatsAndInventory, is_workstation = false):
	tab_container.set_tab_hidden(1, not is_workstation)
	is_workstation_menu = is_workstation
	if is_workstation:
		populate_workstation_tab(stats)
	visible = true
	populate_inventory_tab(stats)
	Events.refresh_stats_and_inventory.connect(_handle_event_refresh_inventory)

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
	Events.refresh_stats_and_inventory.disconnect(_handle_event_refresh_inventory)

func _on_settings_button_pressed():
	print('handle settings menu')

func _handle_event_refresh_inventory(stats: StatsAndInventory):
	populate_inventory_tab(stats)
	if is_workstation_menu:
		populate_workstation_tab(stats)
