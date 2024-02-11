extends Control

@onready var plant_grid_container = $ColorRect/MarginContainer/VBoxContainer/PlantGridContainer
@onready var fruit_grid_container = $ColorRect/MarginContainer/VBoxContainer/FruitGridContainer
@onready var tool_grid_container = $ColorRect/MarginContainer/VBoxContainer/ToolGridContainer

var FruitCell = load("res://scenes/fruit_cell.tscn")
var VegetableCell = load("res://scenes/vegetable_cell.tscn")
var ToolCell = load("res://scenes/tool_cell.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_inventory_display()
	Events.open_menu.connect(open_menu)

func clear_inventory_display():
	for plant in plant_grid_container.get_children():
		plant.queue_free()

	for fruit in fruit_grid_container.get_children():
		fruit.queue_free()

	for tool in tool_grid_container.get_children():
		tool.queue_free()

func open_menu(stats: StatsAndInventory):
	visible = true
	clear_inventory_display()
	for plant in stats.plant_inventory:
		if stats.plant_inventory[plant] == 0:
			continue
		var plant_cell = VegetableCell.instantiate()
		plant_cell.set_data(plant, stats.plant_inventory[plant])
		plant_grid_container.add_child(plant_cell)

	for fruit in stats.fruit_inventory:
		if stats.fruit_inventory[fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.fruit_inventory[fruit])
		fruit_grid_container.add_child(fruit_cell)

	var water_can_cell = ToolCell.instantiate()
	water_can_cell.set_data(Constants.TOOL_TYPE.WateringCan, "%s/%s"%[stats.water_level, stats.water_level_max])
	tool_grid_container.add_child(water_can_cell)

	if stats.has_axe:
		var axe_cell = ToolCell.instantiate()
		axe_cell.set_data(Constants.TOOL_TYPE.Axe, "")
		tool_grid_container.add_child(axe_cell)

	if stats.has_hoe:
		var hoe_cell = ToolCell.instantiate()
		hoe_cell.set_data(Constants.TOOL_TYPE.Hoe, "")
		tool_grid_container.add_child(hoe_cell)


func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
