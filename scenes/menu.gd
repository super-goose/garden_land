extends Control

@onready var seeds_grid_container = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/SeedsSection
@onready var plant_grid_container = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/VegetablesSection
@onready var fruit_grid_container = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/FruitSection
@onready var tools_grid_container = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/ToolsSection

var FruitCell = load("res://scenes/fruit_cell.tscn")
var VegetableCell = load("res://scenes/vegetable_cell.tscn")
var ToolCell = load("res://scenes/tool_cell.tscn")
var SeedsCell = load("res://scenes/seeds_cell.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/MenuHeader.close_button_pressed.connect(_on_close_button_pressed)
	Events.open_menu.connect(open_menu)

func open_menu(stats: StatsAndInventory):
	visible = true
	var plant_inventory = []
	for plant in stats.plant_inventory:
		if stats.plant_inventory[plant] == 0:
			continue
		var plant_cell = VegetableCell.instantiate()
		plant_cell.set_data(plant, stats.plant_inventory[plant])
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
	
	seeds_grid_container.set_items(seeds_inventory)
	plant_grid_container.set_items(plant_inventory)
	fruit_grid_container.set_items(fruit_inventory)
	tools_grid_container.set_items(tools_inventory)

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
