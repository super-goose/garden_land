class_name StatsAndInventory
extends Resource

var fruit_inventory = {
	Constants.FRUIT_TYPE.Apple: 3,
	Constants.FRUIT_TYPE.Orange: 7,
	Constants.FRUIT_TYPE.Pear: 10,
	Constants.FRUIT_TYPE.Peach: 666,
}

var plant_inventory = {
	Constants.PLANT_TYPE.Beet: 2,
	Constants.PLANT_TYPE.BlueFlower: 4,
	Constants.PLANT_TYPE.Carrot: 6,
	Constants.PLANT_TYPE.Cauliflower: 23,
	Constants.PLANT_TYPE.Corn: 76,
	Constants.PLANT_TYPE.Cucumber: 89,
	Constants.PLANT_TYPE.Eggplant: 32,
	Constants.PLANT_TYPE.Lettuce: 4,
	Constants.PLANT_TYPE.Parsnip: 12,
	Constants.PLANT_TYPE.Pumpkin: 888,
	Constants.PLANT_TYPE.Rose: 12,
	Constants.PLANT_TYPE.StarFruit: 98,
	Constants.PLANT_TYPE.Tomato: 7,
	Constants.PLANT_TYPE.Wheat: 80,
}

var seeds_inventory = {
	Constants.SEEDS_TYPE.Beet: 2,
	Constants.SEEDS_TYPE.BlueFlower: 4,
	Constants.SEEDS_TYPE.Carrot: 6,
	Constants.SEEDS_TYPE.Cauliflower: 23,
	Constants.SEEDS_TYPE.Corn: 76,
	Constants.SEEDS_TYPE.Cucumber: 89,
	Constants.SEEDS_TYPE.Eggplant: 32,
	Constants.SEEDS_TYPE.Lettuce: 4,
	Constants.SEEDS_TYPE.Parsnip: 12,
	Constants.SEEDS_TYPE.Pumpkin: 888,
	Constants.SEEDS_TYPE.Rose: 12,
	Constants.SEEDS_TYPE.StarFruit: 98,
	Constants.SEEDS_TYPE.Tomato: 7,
	Constants.SEEDS_TYPE.Wheat: 80,
}

var water_level_max = 8
var water_level = water_level_max
var has_axe = true #false
var has_hoe = true #false
