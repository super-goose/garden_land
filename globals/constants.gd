extends Node

var WALK_SPEED_COEFFICIENT = .3

var NEXT_QUEST_DELIVERY = 5
var SETTINGS_HOUR_DURATION_NORMAL = 5 # 20 
var SETTINGS_HOUR_DURATION_FAST = 5 # 10
var SETTINGS_TREE_HEAL_DURATION = 5
var SETTINGS_CHANCE_OF_RAIN_MIN = 10
var SETTINGS_CHANCE_OF_RAIN_MAX = 20
var SETTINGS_CHANCE_OF_STOPPING_MIN = 60
var SETTINGS_CHANCE_OF_STOPPING_MAX = 70

enum STAGE { empty, sprout, growing, showing, ready, corn }

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

enum ITEM {
	None,
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
	####
	Sunflower,
	SweetPotato,
	Potato,
	Watermelon,
	SweetPea,
	Cantaloupe,
	Onion,
	Pepper,
	PurpleCabbage,
	####
	Apple,
	Orange,
	Pear,
	Peach,
	Strawberry,
	Blackberry,
	Blueberry,
	####
	Honey,
	Egg,
	Milk,
	####
	WateringCan,
	Axe,
	Hoe,

}

const DOUBLE_HEIGHT = [
	Constants.VEGETABLE_TYPE.Corn,
	Constants.VEGETABLE_TYPE.SweetPea,
	Constants.VEGETABLE_TYPE.Pepper,
	Constants.VEGETABLE_TYPE.Sunflower,
]

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
	####
	Sunflower,
	SweetPotato,
	Potato,
	Watermelon,
	SweetPea,
	Cantaloupe,
	Onion,
	Pepper,
	PurpleCabbage,
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

enum CONSUMABLE_TYPE {
	Honey,
	Egg,
	Milk,
	Mushroom,
	None,
}

enum TOOL_TYPE {
	WateringCan,
	Axe,
	Hoe,
	FishingRod
}

enum ACTIONS {
	Menu,
	Chop,
	Water,
	Hoe,
	Sow,
	CheckMail,
	SendMail,
	RefillWater,
	WorkAtStation,
	UseBed,
	Dev,
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
	###
	Harvest_Sunflower,
	Harvest_SweetPotato,
	Harvest_Potato,
	Harvest_Watermelon,
	Harvest_SweetPea,
	Harvest_Cantaloupe,
	Harvest_Onion,
	Harvest_Pepper,
	Harvest_PurpleCabbage,
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
	Constants.VEGETABLE_TYPE.Sunflower: load("res://modified-assets/plant-grow-sprites/sunflower.png"),
	Constants.VEGETABLE_TYPE.SweetPotato: load("res://modified-assets/plant-grow-sprites/sweetpotato.png"),
	Constants.VEGETABLE_TYPE.Potato: load("res://modified-assets/plant-grow-sprites/potato.png"),
	Constants.VEGETABLE_TYPE.Watermelon: load("res://modified-assets/plant-grow-sprites/watermelon.png"),
	Constants.VEGETABLE_TYPE.SweetPea: load("res://modified-assets/plant-grow-sprites/sweetpea.png"),
	Constants.VEGETABLE_TYPE.Cantaloupe: load("res://modified-assets/plant-grow-sprites/cantaloupe.png"),
	Constants.VEGETABLE_TYPE.Onion: load("res://modified-assets/plant-grow-sprites/onion.png"),
	Constants.VEGETABLE_TYPE.Pepper: load("res://modified-assets/plant-grow-sprites/pepper.png"),
	Constants.VEGETABLE_TYPE.PurpleCabbage: load("res://modified-assets/plant-grow-sprites/purplecabbage.png"),
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
	###
	Constants.VEGETABLE_TYPE.Sunflower: Constants.ACTIONS.Harvest_Sunflower,
	Constants.VEGETABLE_TYPE.SweetPotato: Constants.ACTIONS.Harvest_SweetPotato,
	Constants.VEGETABLE_TYPE.Potato: Constants.ACTIONS.Harvest_Potato,
	Constants.VEGETABLE_TYPE.Watermelon: Constants.ACTIONS.Harvest_Watermelon,
	Constants.VEGETABLE_TYPE.SweetPea: Constants.ACTIONS.Harvest_SweetPea,
	Constants.VEGETABLE_TYPE.Cantaloupe: Constants.ACTIONS.Harvest_Cantaloupe,
	Constants.VEGETABLE_TYPE.Onion: Constants.ACTIONS.Harvest_Onion,
	Constants.VEGETABLE_TYPE.Pepper: Constants.ACTIONS.Harvest_Pepper,
	Constants.VEGETABLE_TYPE.PurpleCabbage: Constants.ACTIONS.Harvest_PurpleCabbage,

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
	###
	Constants.VEGETABLE_TYPE.Sunflower: [1, 2],
	Constants.VEGETABLE_TYPE.SweetPotato: [2, 3],
	Constants.VEGETABLE_TYPE.Potato: [2, 4],
	Constants.VEGETABLE_TYPE.Watermelon: [1, 2],
	Constants.VEGETABLE_TYPE.SweetPea: [5, 10],
	Constants.VEGETABLE_TYPE.Cantaloupe: [2, 4],
	Constants.VEGETABLE_TYPE.Onion: [2, 4],
	Constants.VEGETABLE_TYPE.Pepper: [3, 6],
	Constants.VEGETABLE_TYPE.PurpleCabbage: [2, 3],

}

var SEED_YIELD_RANGES_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.StarFruit: [3, 5],
	Constants.VEGETABLE_TYPE.Tomato: [5, 7],
	Constants.VEGETABLE_TYPE.Wheat: [14, 20],
	Constants.VEGETABLE_TYPE.Beet: [4, 5],
	Constants.VEGETABLE_TYPE.BlueFlower: [5, 7],
	Constants.VEGETABLE_TYPE.Carrot: [4, 6],
	Constants.VEGETABLE_TYPE.Cauliflower: [3, 4],
	Constants.VEGETABLE_TYPE.Corn: [14, 20],
	Constants.VEGETABLE_TYPE.Cucumber: [5, 7],
	Constants.VEGETABLE_TYPE.Eggplant: [5, 7],
	Constants.VEGETABLE_TYPE.Rose: [2, 5],
	Constants.VEGETABLE_TYPE.Lettuce: [3, 4],
	Constants.VEGETABLE_TYPE.Parsnip: [4, 6],
	Constants.VEGETABLE_TYPE.Pumpkin: [6, 8],
	###
	Constants.VEGETABLE_TYPE.Sunflower: [12, 20],
	Constants.VEGETABLE_TYPE.SweetPotato: [4, 5],
	Constants.VEGETABLE_TYPE.Potato: [4, 5],
	Constants.VEGETABLE_TYPE.Watermelon: [6, 9],
	Constants.VEGETABLE_TYPE.SweetPea: [4, 7],
	Constants.VEGETABLE_TYPE.Cantaloupe: [6, 9],
	Constants.VEGETABLE_TYPE.Onion: [2, 3],
	Constants.VEGETABLE_TYPE.Pepper: [5, 7],
	Constants.VEGETABLE_TYPE.PurpleCabbage: [3, 4],

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
	Constants.FRUIT_TYPE.Blackberry: load("res://modified-assets/fruit/blackberry.png"),
	Constants.FRUIT_TYPE.Blueberry: load("res://modified-assets/fruit/blueberry.png"),
	Constants.FRUIT_TYPE.Strawberry: load("res://modified-assets/fruit/strawberry.png"),
}

var INDIVIDUAL_PRODUCT_BY_VEGETABLE_TYPE = {
	Constants.VEGETABLE_TYPE.Cantaloupe: load("res://modified-assets/farm-plants/farm-product-cantaloupe.png"),
	Constants.VEGETABLE_TYPE.Sunflower: load("res://modified-assets/farm-plants/farm-product-sunflower-seed.png"),
	Constants.VEGETABLE_TYPE.SweetPea: load("res://modified-assets/farm-plants/farm-product-sweetpea.png"),
	Constants.VEGETABLE_TYPE.Watermelon: load("res://modified-assets/farm-plants/farm-product-watermelon.png"),
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
	Constants.VEGETABLE_TYPE.Sunflower: load("res://modified-assets/farm-plants/farm-plant-sunflower.png"),
	Constants.VEGETABLE_TYPE.SweetPotato: load("res://modified-assets/farm-plants/farm-plant-sweetpotato.png"),
	Constants.VEGETABLE_TYPE.Potato: load("res://modified-assets/farm-plants/farm-plant-potato.png"),
	Constants.VEGETABLE_TYPE.Watermelon: load("res://modified-assets/farm-plants/farm-plant-watermelon.png"),
	Constants.VEGETABLE_TYPE.SweetPea: load("res://modified-assets/farm-plants/farm-plant-sweetpea.png"),
	Constants.VEGETABLE_TYPE.Cantaloupe: load("res://modified-assets/farm-plants/farm-plant-cantaloupe.png"),
	Constants.VEGETABLE_TYPE.Onion: load("res://modified-assets/farm-plants/farm-plant-onion.png"),
	Constants.VEGETABLE_TYPE.Pepper: load("res://modified-assets/farm-plants/farm-plant-pepper.png"),
	Constants.VEGETABLE_TYPE.PurpleCabbage: load("res://modified-assets/farm-plants/farm-plant-purplecabbage.png"),
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
	Constants.VEGETABLE_TYPE.Sunflower: load("res://modified-assets/farm-plants/farm-plant-seed-sunflower.png"),
	Constants.VEGETABLE_TYPE.SweetPotato: load("res://modified-assets/farm-plants/farm-plant-seed-sweetpotato.png"),
	Constants.VEGETABLE_TYPE.Potato: load("res://modified-assets/farm-plants/farm-plant-seed-potato.png"),
	Constants.VEGETABLE_TYPE.Watermelon: load("res://modified-assets/farm-plants/farm-plant-seed-watermelon.png"),
	Constants.VEGETABLE_TYPE.SweetPea: load("res://modified-assets/farm-plants/farm-plant-seed-sweetpea.png"),
	Constants.VEGETABLE_TYPE.Cantaloupe: load("res://modified-assets/farm-plants/farm-plant-seed-cantaloupe.png"),
	Constants.VEGETABLE_TYPE.Onion: load("res://modified-assets/farm-plants/farm-plant-seed-onion.png"),
	Constants.VEGETABLE_TYPE.Pepper: load("res://modified-assets/farm-plants/farm-plant-seed-pepper.png"),
	Constants.VEGETABLE_TYPE.PurpleCabbage: load("res://modified-assets/farm-plants/farm-plant-seed-purplecabbage.png"),
}

var INDIVIDUAL_CONSUMABLE_BY_CONSUMABLE_TYPE = {
	Constants.CONSUMABLE_TYPE.Honey: load("res://modified-assets/consumable/honey.png"),
	Constants.CONSUMABLE_TYPE.Egg: load("res://modified-assets/consumable/egg.png"),
	Constants.CONSUMABLE_TYPE.Milk: load("res://modified-assets/consumable/milk-white.png"),
	Constants.CONSUMABLE_TYPE.Mushroom: load("res://modified-assets/consumable/mushroom.png"),
}
