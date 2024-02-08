class_name StatsAndInventory
extends Resource

var fruit_inventory = {
	Constants.FRUIT_TYPE.Apple: 0,
	Constants.FRUIT_TYPE.Orange: 0,
	Constants.FRUIT_TYPE.Pear: 0,
	Constants.FRUIT_TYPE.Peach: 0,
}
var plant_inventory = {
	Constants.PLANT_TYPE.Beet: 0,
	Constants.PLANT_TYPE.BlueFlower: 0,
	Constants.PLANT_TYPE.Carrot: 0,
	Constants.PLANT_TYPE.Cauliflower: 0,
	Constants.PLANT_TYPE.Corn: 0,
	Constants.PLANT_TYPE.Cucumber: 0,
	Constants.PLANT_TYPE.Eggplant: 0,
	Constants.PLANT_TYPE.Lettuce: 0,
	Constants.PLANT_TYPE.Parsnip: 0,
	Constants.PLANT_TYPE.Pumpkin: 0,
	Constants.PLANT_TYPE.Rose: 0,
	Constants.PLANT_TYPE.StarFruit: 0,
	Constants.PLANT_TYPE.Tomato: 0,
	Constants.PLANT_TYPE.Wheat: 0,
}

var water_level_max = 8
var water_level = water_level_max
var has_axe = false
var has_hoe = false
