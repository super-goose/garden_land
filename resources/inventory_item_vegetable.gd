class_name InventoryItemVegetable
extends "res://resources/inventory_item.gd"

@export var vegetable: Constants.VEGETABLE_TYPE

static func build(veg_type: Constants.VEGETABLE_TYPE, veg_count: int):
	var iiv = InventoryItemVegetable.new()
	iiv.vegetable = veg_type
	iiv.count = veg_count
	return iiv

func to_dict():
	return {
		"vegetable": vegetable,
		"count": count,
	}

static func from_dict(dict: Dictionary):
	var i = InventoryItemVegetable.new()
	i.vegetable = dict['vegetable']
	i.count = dict['count']
	return i
