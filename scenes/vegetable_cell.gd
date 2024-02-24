class_name VegetableCell
extends "res://scenes/bases/inventory_cell.gd"

func set_data(type: Constants.VEGETABLE_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[type]
	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text


