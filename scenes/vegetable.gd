class_name Vegetable
extends "res://scenes/bases/collectible.gd"

var direction: float
var type: Constants.VEGETABLE_TYPE

func _ready():
	do_animation(
		func vegetable_tween_callback():
			Events.harvest_plant.emit(type)
			Events.vegetable_was_harvested.emit()
			queue_free()
	)

#func _init():
#	pass

func set_vegetable_data(vegetable_type: Constants.VEGETABLE_TYPE, index: int):
	type = vegetable_type
	texture = Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[vegetable_type]

	position = [
		Vector2(11, -22),
		Vector2(-11, -22),
		Vector2(11, 22),
		Vector2(-11, 22),
		Vector2(22, -11),
		Vector2(-22, -11),
		Vector2(22, 11),
		Vector2(-22, 11),
	][index]
