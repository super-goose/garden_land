class_name FruitCell
extends Control


func set_data(type: Constants.FRUIT_TYPE, amount: int):
	var texture = {
		Constants.FRUIT_TYPE.Apple: load("res://modified-assets/fruit/apple.png"),
		Constants.FRUIT_TYPE.Orange: load("res://modified-assets/fruit/orange.png"),
		Constants.FRUIT_TYPE.Pear: load("res://modified-assets/fruit/pear.png"),
		Constants.FRUIT_TYPE.Peach: load("res://modified-assets/fruit/peach.png"),
	}[type]

	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
