extends Node

var SETTINGS_HOUR_DURATION = 20 #5 #20
var SETTINGS_CHANCE_OF_RAIN_MIN = 20 # 90 #
var SETTINGS_CHANCE_OF_RAIN_MAX = 40 # 100 #
var SETTINGS_CHANCE_OF_STOPPING_MIN = 60 # 
var SETTINGS_CHANCE_OF_STOPPING_MAX = 70 #

enum TIME {
	AM, PM
}

enum PLANT_TYPE {
	Corn,
	Carrot,
	Cauliflower,
	Tomato,
	Eggplant,
	BlueFlower,
	Lettuce,
	Wheat,
	Pumpkin,
	Parsnip,
	Rose,
	Beet,
	StarFruit,
	Cucumber,
	None,
}

enum FRUIT_TYPE {
	Apple,
	Orange,
	Pear,
	Peach,
	Strawberry,
	Blackberry,
	Blueberry,
	None,
}

enum TOOL_TYPE {
	WateringCan,
	Axe,
	Hoe,
}

enum ACTIONS {
	Menu,
	Chop,
	Water,
	Hoe,
	Sow,
	CheckMail,
	RefillWater,
	WorkAtStation,
	Harvest_Corn,
	Harvest_Carrot,
	Harvest_Cauliflower,
	Harvest_Tomato,
	Harvest_Eggplant,
	Harvest_BlueFlower,
	Harvest_Lettuce,
	Harvest_Wheat,
	Harvest_Pumpkin,
	Harvest_Parsnip,
	Harvest_Rose,
	Harvest_Beet,
	Harvest_StarFruit,
	Harvest_Cucumber,
}

var GROW_SPRITES = {
	Constants.PLANT_TYPE.Corn: load("res://modified-assets/plant-grow-sprites/corn.png"),
	Constants.PLANT_TYPE.Carrot: load("res://modified-assets/plant-grow-sprites/carrot.png"),
	Constants.PLANT_TYPE.Cauliflower: load("res://modified-assets/plant-grow-sprites/cauliflower.png"),
	Constants.PLANT_TYPE.Tomato: load("res://modified-assets/plant-grow-sprites/tomato.png"),
	Constants.PLANT_TYPE.Eggplant: load("res://modified-assets/plant-grow-sprites/eggplant.png"),
	Constants.PLANT_TYPE.BlueFlower: load("res://modified-assets/plant-grow-sprites/flower.png"),
	Constants.PLANT_TYPE.Lettuce: load("res://modified-assets/plant-grow-sprites/lettuce.png"),
	Constants.PLANT_TYPE.Wheat: load("res://modified-assets/plant-grow-sprites/wheat.png"),
	Constants.PLANT_TYPE.Pumpkin: load("res://modified-assets/plant-grow-sprites/pumpkin.png"),
	Constants.PLANT_TYPE.Parsnip: load("res://modified-assets/plant-grow-sprites/parsnip.png"),
	Constants.PLANT_TYPE.Rose: load("res://modified-assets/plant-grow-sprites/rose.png"),
	Constants.PLANT_TYPE.Beet: load("res://modified-assets/plant-grow-sprites/beet.png"),
	Constants.PLANT_TYPE.StarFruit: load("res://modified-assets/plant-grow-sprites/star-fruit.png"),
	Constants.PLANT_TYPE.Cucumber: load("res://modified-assets/plant-grow-sprites/cucumber.png"),
}

var HARVEST_ACTIONS_BY_PLANT_TYPE = {
	Constants.PLANT_TYPE.Corn: Constants.ACTIONS.Harvest_Corn,
	Constants.PLANT_TYPE.Carrot: Constants.ACTIONS.Harvest_Carrot,
	Constants.PLANT_TYPE.Cauliflower: Constants.ACTIONS.Harvest_Cauliflower,
	Constants.PLANT_TYPE.Tomato: Constants.ACTIONS.Harvest_Tomato,
	Constants.PLANT_TYPE.Eggplant: Constants.ACTIONS.Harvest_Eggplant,
	Constants.PLANT_TYPE.BlueFlower: Constants.ACTIONS.Harvest_BlueFlower,
	Constants.PLANT_TYPE.Lettuce: Constants.ACTIONS.Harvest_Lettuce,
	Constants.PLANT_TYPE.Wheat: Constants.ACTIONS.Harvest_Wheat,
	Constants.PLANT_TYPE.Pumpkin: Constants.ACTIONS.Harvest_Pumpkin,
	Constants.PLANT_TYPE.Parsnip: Constants.ACTIONS.Harvest_Parsnip,
	Constants.PLANT_TYPE.Rose: Constants.ACTIONS.Harvest_Rose,
	Constants.PLANT_TYPE.Beet: Constants.ACTIONS.Harvest_Beet,
	Constants.PLANT_TYPE.StarFruit: Constants.ACTIONS.Harvest_StarFruit,
	Constants.PLANT_TYPE.Cucumber: Constants.ACTIONS.Harvest_Cucumber,
}

var HARVEST_YIELD_RANGES_BY_PLANT_TYPE = {
	Constants.PLANT_TYPE.StarFruit: [1, 3],
	Constants.PLANT_TYPE.Tomato: [3, 5],
	Constants.PLANT_TYPE.Wheat: [5, 10],
	Constants.PLANT_TYPE.Beet: [2, 3],
	Constants.PLANT_TYPE.BlueFlower: [3, 5],
	Constants.PLANT_TYPE.Carrot: [2, 4],
	Constants.PLANT_TYPE.Cauliflower: [2, 3],
	Constants.PLANT_TYPE.Corn: [3, 7],
	Constants.PLANT_TYPE.Cucumber: [3, 6],
	Constants.PLANT_TYPE.Eggplant: [2, 4],
	Constants.PLANT_TYPE.Rose: [2, 5],
	Constants.PLANT_TYPE.Lettuce: [2, 3],
	Constants.PLANT_TYPE.Parsnip: [2, 4],
	Constants.PLANT_TYPE.Pumpkin: [1, 3],
}

var INDIVIDUAL_TOOL_BY_TOOL_TYPE = {
	Constants.TOOL_TYPE.Hoe: load("res://modified-assets/tools/tools-hoe.png"),
	Constants.TOOL_TYPE.Axe: load("res://modified-assets/tools/tools-axe.png"),
	Constants.TOOL_TYPE.WateringCan: load("res://modified-assets/tools/tools-water-can.png"),
}

var INDIVIDUAL_FRUIT_BY_FRUIT_TYPE = {
	Constants.FRUIT_TYPE.Apple: load("res://modified-assets/fruit/apple.png"),
	Constants.FRUIT_TYPE.Orange: load("res://modified-assets/fruit/orange.png"),
	Constants.FRUIT_TYPE.Pear: load("res://modified-assets/fruit/pear.png"),
	Constants.FRUIT_TYPE.Peach: load("res://modified-assets/fruit/peach.png"),
}

var INDIVIDUAL_PLANT_BY_PLANT_TYPE = {
	Constants.PLANT_TYPE.StarFruit: load("res://modified-assets/farm-plants/farm-plant-starfruit.png"),
	Constants.PLANT_TYPE.Tomato: load("res://modified-assets/farm-plants/farm-plant-tomato.png"),
	Constants.PLANT_TYPE.Wheat: load("res://modified-assets/farm-plants/farm-plant-wheat.png"),
	Constants.PLANT_TYPE.Beet: load("res://modified-assets/farm-plants/farm-plant-beet.png"),
	Constants.PLANT_TYPE.BlueFlower: load("res://modified-assets/farm-plants/farm-plant-blueflower.png"),
	Constants.PLANT_TYPE.Carrot: load("res://modified-assets/farm-plants/farm-plant-carrot.png"),
	Constants.PLANT_TYPE.Cauliflower: load("res://modified-assets/farm-plants/farm-plant-cauliflower.png"),
	Constants.PLANT_TYPE.Corn: load("res://modified-assets/farm-plants/farm-plant-corn.png"),
	Constants.PLANT_TYPE.Cucumber: load("res://modified-assets/farm-plants/farm-plant-cucumber.png"),
	Constants.PLANT_TYPE.Eggplant: load("res://modified-assets/farm-plants/farm-plant-eggplant.png"),
	Constants.PLANT_TYPE.Rose: load("res://modified-assets/farm-plants/farm-plant-flower.png"),
	Constants.PLANT_TYPE.Lettuce: load("res://modified-assets/farm-plants/farm-plant-lettuce.png"),
	Constants.PLANT_TYPE.Parsnip: load("res://modified-assets/farm-plants/farm-plant-parsnip.png"),
	Constants.PLANT_TYPE.Pumpkin: load("res://modified-assets/farm-plants/farm-plant-pumpkin.png"),
}
