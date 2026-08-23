class_name InventoryItemVegetable
extends "res://resources/inventory_item.gd"

@export var vegetable: Constants.VEGETABLE_TYPE

static func build(veg_type: Constants.VEGETABLE_TYPE, veg_count: int):
	var iiv = InventoryItemVegetable.new()
	iiv.vegetable = veg_type
	iiv.count = veg_count
	return iiv
