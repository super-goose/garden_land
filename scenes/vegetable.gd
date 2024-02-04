class_name Vegetable
extends "res://scenes/script_base/collectible.gd"

var direction: float
var type: Constants.PLANT_TYPE

func _ready():
	do_animation(
		func vegetable_tween_callback():
			Events.harvest_plant.emit(type)
			queue_free()
	)

#func _init():
#	pass

func set_vegetable_data(plant_type: Constants.PLANT_TYPE, index: int):
	type = plant_type
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
	texture = Constants.INDIVIDUAL_PLANT_BY_PLANT_TYPE[plant_type]
