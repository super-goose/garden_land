class_name InventoryItemConsumable
extends "res://resources/inventory_item.gd"

@export var consumable: Constants.CONSUMABLE_TYPE

static func build(consumable_type: Constants.CONSUMABLE_TYPE, consumable_count: int):
	var iic = InventoryItemConsumable.new()
	iic.consumable = consumable_type
	iic.count = consumable_count
	return iic

func to_dict():
	return {
		"consumable": consumable,
		"count": count,
	}

static func from_dict(dict: Dictionary):
	var i = InventoryItemConsumable.new()
	i.consumable = dict['consumable']
	i.count = dict['count']
	return i
