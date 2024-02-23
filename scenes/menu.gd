extends Control

@onready var plant_grid_container = $ColorRect/MarginContainer/VBoxContainer/VegetablesSection
@onready var fruit_grid_container = $ColorRect/MarginContainer/VBoxContainer/FruitSection
@onready var tool_grid_container = $ColorRect/MarginContainer/VBoxContainer/ToolsSection

var FruitCell = load("res://scenes/fruit_cell.tscn")
var VegetableCell = load("res://scenes/vegetable_cell.tscn")
var ToolCell = load("res://scenes/tool_cell.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
#	clear_inventory_display()
	Events.open_menu.connect(open_menu)

#func clear_inventory_display():
#	plant_grid_container.clear_items()
#	fruit_grid_container.clear_items()
#	tool_grid_container.clear_items()

func open_menu(stats: StatsAndInventory):
	visible = true
#	clear_inventory_display()
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

	plant_grid_container.set_items(plant_inventory)
	fruit_grid_container.set_items(fruit_inventory)
	tool_grid_container.set_items(tools_inventory)

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
