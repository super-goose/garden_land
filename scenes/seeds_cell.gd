class_name SeedsCell
extends "res://scenes/bases/inventory_cell.gd"

func set_data(type: Constants.VEGETABLE_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_SEEDS_BY_SEED_TYPE[type]
	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
