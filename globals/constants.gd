extends Node

var WALK_SPEED_COEFFICIENT = .5

var SETTINGS_HOUR_DURATION_NORMAL = 20 
var SETTINGS_HOUR_DURATION_FAST = 5 # 10
var SETTINGS_CHANCE_OF_RAIN_MIN = 10
var SETTINGS_CHANCE_OF_RAIN_MAX = 20
var SETTINGS_CHANCE_OF_STOPPING_MIN = 60
var SETTINGS_CHANCE_OF_STOPPING_MAX = 70

enum TIME {
	AM, PM
}

#enum SEED_TYPE {
	#Corn,
	#Carrot,
	#Cauliflower,
	#Tomato,
	#Eggplant,
	#BlueFlower,
	#Lettuce,
	#Wheat,
	#Pumpkin,
	#Parsnip,
	#Rose,
	#Beet,
	#StarFruit,
	#Cucumber,
	#None,
#}

enum VEGETABLE_TYPE {
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
	UseBed,
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
	Constants.VEGETABLE_TYPE.Corn: load("res://modified-assets/plant-grow-sprites/corn.png"),
	Constants.VEGETABLE_TYPE.Carrot: load("res://modified-assets/plant-grow-sprites/carrot.png"),
	Constants.VEGETABLE_TYPE.Cauliflower: load("res://modified-assets/plant-grow-sprites/cauliflower.png"),
	Constants.VEGETABLE_TYPE.Tomato: load("res://modified-assets/plant-grow-sprites/tomato.png"),
	Constants.VEGETABLE_TYPE.Eggplant: load("res://modified-assets/plant-grow-sprites/eggplant.png"),
	Constants.VEGETABLE_TYPE.BlueFlower: load("res://modified-assets/plant-grow-sprites/flower.png"),
	Constants.VEGETABLE_TYPE.Lettuce: load("res://modified-assets/plant-grow-sprites/lettuce.png"),
	Constants.VEGETABLE_TYPE.Wheat: load("res://modified-assets/plant-grow-sprites/wheat.png"),
	Constants.VEGETABLE_TYPE.Pumpkin: load("res://modified-assets/plant-grow-sprites/pumpkin.png"),
	Constants.VEGETABLE_TYPE.Parsnip: load("res://modified-assets/plant-grow-sprites/parsnip.png"),
	Constants.VEGETABLE_TYPE.Rose: load("res://modified-assets/plant-grow-sprites/rose.png"),
	Constants.VEGETABLE_TYPE.Beet: load("res://modified-assets/plant-grow-sprites/beet.png"),
	Constants.VEGETABLE_TYPE.StarFruit: load("res://modified-assets/plant-grow-sprites/star-fruit.png"),
	Constants.VEGETABLE_TYPE.Cucumber: load("res://modified-assets/plant-grow-sprites/cucumber.png"),
}

var HARVEST_ACTIONS_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.Corn: Constants.ACTIONS.Harvest_Corn,
	Constants.VEGETABLE_TYPE.Carrot: Constants.ACTIONS.Harvest_Carrot,
	Constants.VEGETABLE_TYPE.Cauliflower: Constants.ACTIONS.Harvest_Cauliflower,
	Constants.VEGETABLE_TYPE.Tomato: Constants.ACTIONS.Harvest_Tomato,
	Constants.VEGETABLE_TYPE.Eggplant: Constants.ACTIONS.Harvest_Eggplant,
	Constants.VEGETABLE_TYPE.BlueFlower: Constants.ACTIONS.Harvest_BlueFlower,
	Constants.VEGETABLE_TYPE.Lettuce: Constants.ACTIONS.Harvest_Lettuce,
	Constants.VEGETABLE_TYPE.Wheat: Constants.ACTIONS.Harvest_Wheat,
	Constants.VEGETABLE_TYPE.Pumpkin: Constants.ACTIONS.Harvest_Pumpkin,
	Constants.VEGETABLE_TYPE.Parsnip: Constants.ACTIONS.Harvest_Parsnip,
	Constants.VEGETABLE_TYPE.Rose: Constants.ACTIONS.Harvest_Rose,
	Constants.VEGETABLE_TYPE.Beet: Constants.ACTIONS.Harvest_Beet,
	Constants.VEGETABLE_TYPE.StarFruit: Constants.ACTIONS.Harvest_StarFruit,
	Constants.VEGETABLE_TYPE.Cucumber: Constants.ACTIONS.Harvest_Cucumber,
}

var HARVEST_YIELD_RANGES_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.StarFruit: [1, 3],
	Constants.VEGETABLE_TYPE.Tomato: [3, 5],
	Constants.VEGETABLE_TYPE.Wheat: [5, 10],
	Constants.VEGETABLE_TYPE.Beet: [2, 3],
	Constants.VEGETABLE_TYPE.BlueFlower: [3, 5],
	Constants.VEGETABLE_TYPE.Carrot: [2, 4],
	Constants.VEGETABLE_TYPE.Cauliflower: [2, 3],
	Constants.VEGETABLE_TYPE.Corn: [3, 7],
	Constants.VEGETABLE_TYPE.Cucumber: [3, 6],
	Constants.VEGETABLE_TYPE.Eggplant: [2, 4],
	Constants.VEGETABLE_TYPE.Rose: [2, 5],
	Constants.VEGETABLE_TYPE.Lettuce: [2, 3],
	Constants.VEGETABLE_TYPE.Parsnip: [2, 4],
	Constants.VEGETABLE_TYPE.Pumpkin: [1, 3],
}

var SEED_YIELD_RANGES_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.StarFruit: [3, 5],
	Constants.VEGETABLE_TYPE.Tomato: [5, 7],
	Constants.VEGETABLE_TYPE.Wheat: [8, 14],
	Constants.VEGETABLE_TYPE.Beet: [4,5],
	Constants.VEGETABLE_TYPE.BlueFlower: [5, 7],
	Constants.VEGETABLE_TYPE.Carrot: [4, 6],
	Constants.VEGETABLE_TYPE.Cauliflower: [3, 4],
	Constants.VEGETABLE_TYPE.Corn: [6, 9],
	Constants.VEGETABLE_TYPE.Cucumber: [5, 7],
	Constants.VEGETABLE_TYPE.Eggplant: [5, 7],
	Constants.VEGETABLE_TYPE.Rose: [2, 5],
	Constants.VEGETABLE_TYPE.Lettuce: [3, 4],
	Constants.VEGETABLE_TYPE.Parsnip: [4, 6],
	Constants.VEGETABLE_TYPE.Pumpkin: [6, 8],
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

var INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.StarFruit: load("res://modified-assets/farm-plants/farm-plant-starfruit.png"),
	Constants.VEGETABLE_TYPE.Tomato: load("res://modified-assets/farm-plants/farm-plant-tomato.png"),
	Constants.VEGETABLE_TYPE.Wheat: load("res://modified-assets/farm-plants/farm-plant-wheat.png"),
	Constants.VEGETABLE_TYPE.Beet: load("res://modified-assets/farm-plants/farm-plant-beet.png"),
	Constants.VEGETABLE_TYPE.BlueFlower: load("res://modified-assets/farm-plants/farm-plant-blueflower.png"),
	Constants.VEGETABLE_TYPE.Carrot: load("res://modified-assets/farm-plants/farm-plant-carrot.png"),
	Constants.VEGETABLE_TYPE.Cauliflower: load("res://modified-assets/farm-plants/farm-plant-cauliflower.png"),
	Constants.VEGETABLE_TYPE.Corn: load("res://modified-assets/farm-plants/farm-plant-corn.png"),
	Constants.VEGETABLE_TYPE.Cucumber: load("res://modified-assets/farm-plants/farm-plant-cucumber.png"),
	Constants.VEGETABLE_TYPE.Eggplant: load("res://modified-assets/farm-plants/farm-plant-eggplant.png"),
	Constants.VEGETABLE_TYPE.Rose: load("res://modified-assets/farm-plants/farm-plant-flower.png"),
	Constants.VEGETABLE_TYPE.Lettuce: load("res://modified-assets/farm-plants/farm-plant-lettuce.png"),
	Constants.VEGETABLE_TYPE.Parsnip: load("res://modified-assets/farm-plants/farm-plant-parsnip.png"),
	Constants.VEGETABLE_TYPE.Pumpkin: load("res://modified-assets/farm-plants/farm-plant-pumpkin.png"),
}

var INDIVIDUAL_SEEDS_BY_SEED_TYPE = {
	Constants.VEGETABLE_TYPE.Corn: load("res://modified-assets/farm-plants/farm-plant-seed-corn.png"),
	Constants.VEGETABLE_TYPE.Carrot: load("res://modified-assets/farm-plants/farm-plant-seed-carrot.png"),
	Constants.VEGETABLE_TYPE.Cauliflower: load("res://modified-assets/farm-plants/farm-plant-seed-cauliflower.png"),
	Constants.VEGETABLE_TYPE.Tomato: load("res://modified-assets/farm-plants/farm-plant-seed-tomato.png"),
	Constants.VEGETABLE_TYPE.Eggplant: load("res://modified-assets/farm-plants/farm-plant-seed-eggplant.png"),
	Constants.VEGETABLE_TYPE.BlueFlower: load("res://modified-assets/farm-plants/farm-plant-seed-blueflower.png"),
	Constants.VEGETABLE_TYPE.Lettuce: load("res://modified-assets/farm-plants/farm-plant-seed-lettuce.png"),
	Constants.VEGETABLE_TYPE.Wheat: load("res://modified-assets/farm-plants/farm-plant-seed-wheat.png"),
	Constants.VEGETABLE_TYPE.Pumpkin: load("res://modified-assets/farm-plants/farm-plant-seed-pumpkin.png"),
	Constants.VEGETABLE_TYPE.Parsnip: load("res://modified-assets/farm-plants/farm-plant-seed-parsnip.png"),
	Constants.VEGETABLE_TYPE.Rose: load("res://modified-assets/farm-plants/farm-plant-seed-flower.png"),
	Constants.VEGETABLE_TYPE.Beet: load("res://modified-assets/farm-plants/farm-plant-seed-beet.png"),
	Constants.VEGETABLE_TYPE.StarFruit: load("res://modified-assets/farm-plants/farm-plant-seed-starfruit.png"),
	Constants.VEGETABLE_TYPE.Cucumber: load("res://modified-assets/farm-plants/farm-plant-seed-cucumber.png"),
}
