class_name InventoryItemConsumable
extends "res://resources/inventory_item.gd"

@export var consumable: Constants.CONSUMABLE_TYPE

static func build(consumable_type: Constants.CONSUMABLE_TYPE, consumable_count: int):
	var iic = InventoryItemConsumable.new()
	iic.consumable = consumable_type
	iic.count = consumable_count
	return iic
