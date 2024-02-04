extends Node

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

enum ACTIONS {
	Chop,
	Water,
	Hoe,
	Sow,
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
