class_name InventoryItemFruit
extends "res://resources/inventory_item.gd"

@export var fruit: Constants.FRUIT_TYPE

static func build(fruit_type: Constants.FRUIT_TYPE, fruit_count: int):
	var iif = InventoryItemFruit.new()
	iif.fruit = fruit_type
	iif.count = fruit_count
	return iif
