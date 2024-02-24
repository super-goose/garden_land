class_name StatsAndInventory
extends Resource

var fruit_inventory = {
	Constants.FRUIT_TYPE.Apple: 3,
	Constants.FRUIT_TYPE.Orange: 7,
	Constants.FRUIT_TYPE.Pear: 10,
	Constants.FRUIT_TYPE.Peach: 666,
}

var plant_inventory = {
	Constants.VEGETABLE_TYPE.Beet: 2,
	Constants.VEGETABLE_TYPE.BlueFlower: 4,
	Constants.VEGETABLE_TYPE.Carrot: 6,
	Constants.VEGETABLE_TYPE.Cauliflower: 23,
	Constants.VEGETABLE_TYPE.Corn: 76,
	Constants.VEGETABLE_TYPE.Cucumber: 89,
	Constants.VEGETABLE_TYPE.Eggplant: 32,
	Constants.VEGETABLE_TYPE.Lettuce: 4,
	Constants.VEGETABLE_TYPE.Parsnip: 12,
	Constants.VEGETABLE_TYPE.Pumpkin: 888,
	Constants.VEGETABLE_TYPE.Rose: 12,
	Constants.VEGETABLE_TYPE.StarFruit: 98,
	Constants.VEGETABLE_TYPE.Tomato: 7,
	Constants.VEGETABLE_TYPE.Wheat: 80,
}

var seeds_inventory = {
	Constants.SEED_TYPE.Beet: 2,
	Constants.SEED_TYPE.BlueFlower: 4,
	Constants.SEED_TYPE.Carrot: 6,
	Constants.SEED_TYPE.Cauliflower: 23,
	Constants.SEED_TYPE.Corn: 76,
	Constants.SEED_TYPE.Cucumber: 89,
	Constants.SEED_TYPE.Eggplant: 32,
	Constants.SEED_TYPE.Lettuce: 4,
	Constants.SEED_TYPE.Parsnip: 12,
	Constants.SEED_TYPE.Pumpkin: 888,
	Constants.SEED_TYPE.Rose: 12,
	Constants.SEED_TYPE.StarFruit: 98,
	Constants.SEED_TYPE.Tomato: 7,
	Constants.SEED_TYPE.Wheat: 80,
}

var box_inventory = {
	"seeds": {
		Constants.SEED_TYPE.Beet: 2,
		Constants.SEED_TYPE.BlueFlower: 4,
		Constants.SEED_TYPE.Carrot: 6,
		Constants.SEED_TYPE.Cauliflower: 23,
		Constants.SEED_TYPE.Corn: 76,
		Constants.SEED_TYPE.Cucumber: 89,
		Constants.SEED_TYPE.Eggplant: 32,
		Constants.SEED_TYPE.Lettuce: 4,
		Constants.SEED_TYPE.Parsnip: 12,
		Constants.SEED_TYPE.Pumpkin: 888,
		Constants.SEED_TYPE.Rose: 12,
		Constants.SEED_TYPE.StarFruit: 98,
		Constants.SEED_TYPE.Tomato: 7,
		Constants.SEED_TYPE.Wheat: 80,
	},
	"fruit": {
		Constants.FRUIT_TYPE.Apple: 3,
		Constants.FRUIT_TYPE.Orange: 7,
		Constants.FRUIT_TYPE.Pear: 10,
		Constants.FRUIT_TYPE.Peach: 666,
	},
	"vegetable": {
		Constants.VEGETABLE_TYPE.Beet: 2,
		Constants.VEGETABLE_TYPE.BlueFlower: 4,
		Constants.VEGETABLE_TYPE.Carrot: 6,
		Constants.VEGETABLE_TYPE.Cauliflower: 23,
		Constants.VEGETABLE_TYPE.Corn: 76,
		Constants.VEGETABLE_TYPE.Cucumber: 89,
		Constants.VEGETABLE_TYPE.Eggplant: 32,
		Constants.VEGETABLE_TYPE.Lettuce: 4,
		Constants.VEGETABLE_TYPE.Parsnip: 12,
		Constants.VEGETABLE_TYPE.Pumpkin: 888,
		Constants.VEGETABLE_TYPE.Rose: 12,
		Constants.VEGETABLE_TYPE.StarFruit: 98,
		Constants.VEGETABLE_TYPE.Tomato: 7,
		Constants.VEGETABLE_TYPE.Wheat: 80,
	}
}

var water_level_max = 8
var water_level = water_level_max
var has_axe = true #false
var has_hoe = true #false
