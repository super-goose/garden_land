class_name FruitCell
extends "res://scenes/bases/inventory_cell.gd"

func set_data(type: Constants.FRUIT_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_FRUIT_BY_FRUIT_TYPE[type]
	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
