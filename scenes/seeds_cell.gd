class_name SeedsCell
extends Control


func set_data(type: Constants.SEEDS_TYPE, amount: int):
	var texture = Constants.INDIVIDUAL_SEEDS_BY_SEEDS_TYPE[type]
	var text = "%s"%amount
	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = text
