class_name InventoryItemFruit
extends "res://resources/inventory_item.gd"

@export var fruit: Constants.FRUIT_TYPE

static func build(fruit_type: Constants.FRUIT_TYPE, fruit_count: int):
	var iif = InventoryItemFruit.new()
	iif.fruit = fruit_type
	iif.count = fruit_count
	return iif

func to_dict():
	return {
		"fruit": fruit,
		"count": count,
	}

static func from_dict(dict: Dictionary):
	var i = InventoryItemFruit.new()
	i.fruit = dict['fruit']
	i.count = dict['count']
	return i
