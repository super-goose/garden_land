class_name Inventory
extends Resource

#@export var seeds: Array[InventoryItemVegetable]
#
#@export var vegetables: Array[InventoryItemVegetable]
#
#@export var fruit: Array[InventoryItemFruit]
#
#@export var consumable: Array[InventoryItemConsumable]


@export var seed = {
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
}
@export var fruit = {
	Constants.FRUIT_TYPE.Apple: 0, #3,
	Constants.FRUIT_TYPE.Orange: 0, #7,
	Constants.FRUIT_TYPE.Pear: 0, #10,
	Constants.FRUIT_TYPE.Peach: 0, #666,
};

@export var vegetable = {
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
}

@export var consumable = {
	Constants.CONSUMABLE_TYPE.Egg: 0,
	Constants.CONSUMABLE_TYPE.Milk: 0,
	Constants.CONSUMABLE_TYPE.Honey: 0,
	Constants.CONSUMABLE_TYPE.Mushroom: 0,
}
