class_name SeedButton
extends Control

var type: Constants.VEGETABLE_TYPE

func set_button_type(_type: Constants.VEGETABLE_TYPE):
	type = _type
	$TextureRect.texture = Constants.INDIVIDUAL_SEEDS_BY_SEED_TYPE[_type]

func _on_button_pressed():
	Events.select_seed_type.emit(type)
	Events.hide_seed_options.emit()

func set_amount(amount: int):
	$TextureRect/Label.visible = amount > 0
	$TextureRect/Label.text = "%s" % amount
