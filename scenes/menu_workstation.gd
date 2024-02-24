extends Control

@onready var seeds_section = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/SeedsSection
@onready var plant_section = $MarginContainer/VBoxContainer/ContentContainer/ScrollContainer/VBoxContainer/VegetablesSection

var FruitCell = load("res://scenes/fruit_cell.tscn")
var VegetableCell = load("res://scenes/vegetable_cell.tscn")
var SeedsCell = load("res://scenes/seeds_cell.tscn")

func _ready():
	$MarginContainer/VBoxContainer/MenuHeader.close_button_pressed.connect(_on_close_button_pressed)
	Events.open_workstation_menu.connect(open_menu)

func open_vegetable_processing_menu(type: Constants.VEGETABLE_TYPE):
	print('add to box')
	print('harvest seeds')

func open_seed_processing_menu(type: Constants.SEED_TYPE):
	print('add to box')

func open_fruit_processing_menu(type: Constants.FRUIT_TYPE):
	print('add to box')

func open_menu(stats: StatsAndInventory):
	visible = true

	var plant_inventory = []
	for plant in stats.plant_inventory:
		if stats.plant_inventory[plant] == 0:
			continue
		var plant_cell = VegetableCell.instantiate()
		plant_cell.set_data(plant, stats.plant_inventory[plant])
		plant_cell.set_functionality(
			func _press_vegetable_cell():
				open_vegetable_processing_menu(plant)
		)
		plant_inventory.push_back(plant_cell)

	var fruit_inventory = []
	for fruit in stats.fruit_inventory:
		if stats.fruit_inventory[fruit] == 0:
			continue
		var fruit_cell = FruitCell.instantiate()
		fruit_cell.set_data(fruit, stats.fruit_inventory[fruit])
		fruit_inventory.push_back(fruit_cell)

	var seeds_inventory = []
	for seeds in stats.seeds_inventory:
		if stats.seeds_inventory[seeds] == 0:
			continue
		var seeds_cell = SeedsCell.instantiate()
		seeds_cell.set_data(seeds, stats.seeds_inventory[seeds])
		seeds_inventory.push_back(seeds_cell)
	
	seeds_section.set_items(seeds_inventory)
	plant_section.set_items(plant_inventory)



func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
