class_name VegetableCell
extends Control


func set_data(type: Constants.PLANT_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_PLANT_BY_PLANT_TYPE[type]
	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
