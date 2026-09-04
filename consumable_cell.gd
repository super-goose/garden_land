class_name ConsumableCell
extends "res://scenes/bases/inventory_cell.gd"

func set_data(type: Constants.CONSUMABLE_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_CONSUMABLE_BY_CONSUMABLE_TYPE[type]
	var text = "%s" % amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
