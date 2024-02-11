class_name FruitCell
extends Control


func set_data(type: Constants.FRUIT_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_FRUIT_BY_FRUIT_TYPE[type]

	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
