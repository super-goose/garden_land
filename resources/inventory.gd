class_name Inventory
extends Resource

func to_dict():
	var seed_ = {}
	var vegetable_ = {}
	for v_type in Constants.VEGETABLE_TYPE:
		if v_type == 'None':
			continue
		seed_[v_type] = seed[Constants.VEGETABLE_TYPE[v_type]]
		vegetable_[v_type] = vegetable[Constants.VEGETABLE_TYPE[v_type]]

	var fruit_ = {}
	for f_type in Constants.FRUIT_TYPE:
		if f_type == 'None':
			continue
		fruit_[f_type] = fruit[Constants.FRUIT_TYPE[f_type]]

	var consumable_ = {}
	for c_type in Constants.CONSUMABLE_TYPE:
		if c_type == 'None':
			continue
		consumable_[c_type] = consumable[Constants.CONSUMABLE_TYPE[c_type]]
	
	return {
		"seed": seed_,
		"vegetable": vegetable_,
		"fruit": fruit_,
		"consumable": consumable_,
	}

static func from_dict(data: Dictionary):
	var i = Inventory.new()

	for v_type in Constants.VEGETABLE_TYPE:
		if v_type == 'None':
			continue

		i.seed[Constants.VEGETABLE_TYPE[v_type]] = data["seed"][v_type]
		i.vegetable_[Constants.VEGETABLE_TYPE[v_type]] = data["vegetable"][v_type]

	for f_type in Constants.FRUIT_TYPE:
		if f_type == 'None':
			continue

		i.fruit_[Constants.FRUIT_TYPE[f_type]] = data["fruit"][f_type]

	for c_type in Constants.CONSUMABLE_TYPE:
		if c_type == 'None':
			continue

		i.consumable_[Constants.CONSUMABLE_TYPE[c_type]] = data["consumable"][c_type]

	return i


@warning_ignore("shadowed_global_identifier")
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
	Constants.FRUIT_TYPE.Strawberry: 0,
	Constants.FRUIT_TYPE.Blackberry: 0,
	Constants.FRUIT_TYPE.Blueberry: 0,
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
