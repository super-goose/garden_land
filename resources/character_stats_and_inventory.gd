class_name StatsAndInventory
extends Resource

@export var fruit_inventory = {
	Constants.FRUIT_TYPE.Apple: 0, #3,
	Constants.FRUIT_TYPE.Orange: 0, #7,
	Constants.FRUIT_TYPE.Pear: 0, #10,
	Constants.FRUIT_TYPE.Peach: 0, #666,
}

@export var vegetable_inventory = {
	Constants.VEGETABLE_TYPE.Beet: 0, #2,
	Constants.VEGETABLE_TYPE.BlueFlower: 0, #4,
	Constants.VEGETABLE_TYPE.Carrot: 0, #6,
	Constants.VEGETABLE_TYPE.Cauliflower: 0, #23,
	Constants.VEGETABLE_TYPE.Corn: 0, #76,
	Constants.VEGETABLE_TYPE.Cucumber: 0, #89,
	Constants.VEGETABLE_TYPE.Eggplant: 0, #32,
	Constants.VEGETABLE_TYPE.Lettuce: 0, #4,
	Constants.VEGETABLE_TYPE.Parsnip: 0, #12,
	Constants.VEGETABLE_TYPE.Pumpkin: 0, #888,
	Constants.VEGETABLE_TYPE.Rose: 0, #12,
	Constants.VEGETABLE_TYPE.StarFruit: 0, #98,
	Constants.VEGETABLE_TYPE.Tomato: 0, #7,
	Constants.VEGETABLE_TYPE.Wheat: 0, #80,

	Constants.VEGETABLE_TYPE.Sunflower: 0,
	Constants.VEGETABLE_TYPE.SweetPotato: 0,
	Constants.VEGETABLE_TYPE.Potato: 0,
	Constants.VEGETABLE_TYPE.Watermelon: 0,
	Constants.VEGETABLE_TYPE.SweetPea: 0,
	Constants.VEGETABLE_TYPE.Cantaloupe: 0,
	Constants.VEGETABLE_TYPE.Onion: 0,
	Constants.VEGETABLE_TYPE.Pepper: 0,
	Constants.VEGETABLE_TYPE.PurpleCabbage: 0,
}

@export var seeds_inventory = {
	Constants.VEGETABLE_TYPE.BlueFlower: 0,
	Constants.VEGETABLE_TYPE.Rose: 0,
	Constants.VEGETABLE_TYPE.StarFruit: 0,

	Constants.VEGETABLE_TYPE.Beet: 2,
	Constants.VEGETABLE_TYPE.Carrot: 6,
	Constants.VEGETABLE_TYPE.Cauliflower: 2,
	Constants.VEGETABLE_TYPE.Corn: 6,
	Constants.VEGETABLE_TYPE.Cucumber: 8,
	Constants.VEGETABLE_TYPE.Eggplant: 3,
	Constants.VEGETABLE_TYPE.Lettuce: 4,
	Constants.VEGETABLE_TYPE.Parsnip: 12,
	Constants.VEGETABLE_TYPE.Pumpkin: 8,
	Constants.VEGETABLE_TYPE.Tomato: 7,
	Constants.VEGETABLE_TYPE.Wheat: 8,
	###
	Constants.VEGETABLE_TYPE.Sunflower: 2,
	Constants.VEGETABLE_TYPE.SweetPotato: 2,
	Constants.VEGETABLE_TYPE.Potato: 2,
	Constants.VEGETABLE_TYPE.Watermelon: 2,
	Constants.VEGETABLE_TYPE.SweetPea: 2,
	Constants.VEGETABLE_TYPE.Cantaloupe: 2,
	Constants.VEGETABLE_TYPE.Onion: 2,
	Constants.VEGETABLE_TYPE.Pepper: 2,
	Constants.VEGETABLE_TYPE.PurpleCabbage: 2,
}

@export var box_inventory = {
	"seeds": {
		Constants.VEGETABLE_TYPE.Beet: 0, #2,
		Constants.VEGETABLE_TYPE.BlueFlower: 0, #4,
		Constants.VEGETABLE_TYPE.Carrot: 0, #6,
		Constants.VEGETABLE_TYPE.Cauliflower: 0, #23,
		Constants.VEGETABLE_TYPE.Corn: 0, #76,
		Constants.VEGETABLE_TYPE.Cucumber: 0, #89,
		Constants.VEGETABLE_TYPE.Eggplant: 0, #32,
		Constants.VEGETABLE_TYPE.Lettuce: 0, #4,
		Constants.VEGETABLE_TYPE.Parsnip: 0, #12,
		Constants.VEGETABLE_TYPE.Pumpkin: 0, #888,
		Constants.VEGETABLE_TYPE.Rose: 0, #12,
		Constants.VEGETABLE_TYPE.StarFruit: 0, #98,
		Constants.VEGETABLE_TYPE.Tomato: 0, #7,
		Constants.VEGETABLE_TYPE.Wheat: 0, #80,
		####
		Constants.VEGETABLE_TYPE.Sunflower: 0,
		Constants.VEGETABLE_TYPE.SweetPotato: 0,
		Constants.VEGETABLE_TYPE.Potato: 0,
		Constants.VEGETABLE_TYPE.Watermelon: 0,
		Constants.VEGETABLE_TYPE.SweetPea: 0,
		Constants.VEGETABLE_TYPE.Cantaloupe: 0,
		Constants.VEGETABLE_TYPE.Onion: 0,
		Constants.VEGETABLE_TYPE.Pepper: 0,
		Constants.VEGETABLE_TYPE.PurpleCabbage: 0,

	},
	"fruit": {
		Constants.FRUIT_TYPE.Apple: 0, #3,
		Constants.FRUIT_TYPE.Orange: 0, #7,
		Constants.FRUIT_TYPE.Pear: 0, #10,
		Constants.FRUIT_TYPE.Peach: 0, #666,
	},
	"vegetable": {
		Constants.VEGETABLE_TYPE.Beet: 0, #2,
		Constants.VEGETABLE_TYPE.BlueFlower: 0, #4,
		Constants.VEGETABLE_TYPE.Carrot: 0, #6,
		Constants.VEGETABLE_TYPE.Cauliflower: 0, #23,
		Constants.VEGETABLE_TYPE.Corn: 0, #76,
		Constants.VEGETABLE_TYPE.Cucumber: 0, #89,
		Constants.VEGETABLE_TYPE.Eggplant: 0, #32,
		Constants.VEGETABLE_TYPE.Lettuce: 0, #4,
		Constants.VEGETABLE_TYPE.Parsnip: 0, #12,
		Constants.VEGETABLE_TYPE.Pumpkin: 0, #888,
		Constants.VEGETABLE_TYPE.Rose: 0, #12,
		Constants.VEGETABLE_TYPE.StarFruit: 0, #98,
		Constants.VEGETABLE_TYPE.Tomato: 0, #7,
		Constants.VEGETABLE_TYPE.Wheat: 0, #80,
		###
		Constants.VEGETABLE_TYPE.Sunflower: 0,
		Constants.VEGETABLE_TYPE.SweetPotato: 0,
		Constants.VEGETABLE_TYPE.Potato: 0,
		Constants.VEGETABLE_TYPE.Watermelon: 0,
		Constants.VEGETABLE_TYPE.SweetPea: 0,
		Constants.VEGETABLE_TYPE.Cantaloupe: 0,
		Constants.VEGETABLE_TYPE.Onion: 0,
		Constants.VEGETABLE_TYPE.Pepper: 0,
		Constants.VEGETABLE_TYPE.PurpleCabbage: 0,
	},
	#####
	"other": {
		Constants.CONSUMABLE_TYPE.Egg: 0,
		Constants.CONSUMABLE_TYPE.Milk: 0,
		Constants.CONSUMABLE_TYPE.Honey: 0,
	}
}

@export var water_level_max = 8
@export var water_level = water_level_max
@export var has_axe = true #false
@export var has_hoe = true #false

func add_fruit_to_box(fruit_type: Constants.FRUIT_TYPE, amount: int):
	if fruit_inventory[fruit_type] == 0:
		return
	fruit_inventory[fruit_type] -= amount
	box_inventory['fruit'][fruit_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_fruit_from_box(fruit_type: Constants.FRUIT_TYPE, amount: int):
	if box_inventory['fruit'][fruit_type] == 0:
		return
	fruit_inventory[fruit_type] += amount
	box_inventory['fruit'][fruit_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func add_vegetable_to_box(vegetable_type: Constants.VEGETABLE_TYPE, amount: int):
	if vegetable_inventory[vegetable_type] == 0:
		return
	vegetable_inventory[vegetable_type] -= amount
	box_inventory['vegetable'][vegetable_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_vegetable_from_box(vegetable_type: Constants.VEGETABLE_TYPE, amount: int):
	if box_inventory['vegetable'][vegetable_type] == 0:
		return
	vegetable_inventory[vegetable_type] += amount
	box_inventory['vegetable'][vegetable_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func add_seeds_to_box(seeds_type: Constants.VEGETABLE_TYPE, amount: int):
	if seeds_inventory[seeds_type] == 0:
		return
	seeds_inventory[seeds_type] -= amount
	box_inventory['seeds'][seeds_type] += amount
	Events.refresh_stats_and_inventory.emit(self)

func remove_seeds_from_box(seeds_type: Constants.VEGETABLE_TYPE, amount: int):
	if box_inventory['seeds'][seeds_type] == 0:
		return
	seeds_inventory[seeds_type] += amount
	box_inventory['seeds'][seeds_type] -= amount
	Events.refresh_stats_and_inventory.emit(self)

func empty_box():
	for seed_type in Constants.VEGETABLE_TYPE:
		box_inventory['seeds'][seed_type] = 0

	for fruit_type in Constants.FRUIT_TYPE:
		box_inventory['fruit'][fruit_type] = 0

	for vegetable_type in Constants.VEGETABLE_TYPE:
		box_inventory['vegetable'][vegetable_type] = 0

	Events.refresh_stats_and_inventory.emit(self)


func convert_vegetable_to_seeds(vegetable_type: Constants.VEGETABLE_TYPE):
	if vegetable_inventory[vegetable_type] == 0:
		return

	var harvest_range = Constants.SEED_YIELD_RANGES_BY_VEGETABLE_TYPE[vegetable_type]
	var harvest_yield = Dice.roll_d_range(harvest_range[0], harvest_range[1])
	
	vegetable_inventory[vegetable_type] -= 1
	seeds_inventory[vegetable_type] += harvest_yield
	Events.refresh_stats_and_inventory.emit(self)
