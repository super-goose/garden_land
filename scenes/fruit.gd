class_name Fruit
extends "res://scenes/bases/collectible.gd"

var direction: float
var type: Constants.FRUIT_TYPE

var fruit_data = {
		'apple': {
			'type': Constants.FRUIT_TYPE.Apple,
			'position': [
				Vector2(-23, -7),
				Vector2(16, -11),
				Vector2(13, -3),
			],
		},
		'orange': {
			'type': Constants.FRUIT_TYPE.Orange,
			'position': [
				Vector2(-22, -9),
				Vector2(-19, 0),
				Vector2(14, -4),
			],
		},
		'pear': {
			'type': Constants.FRUIT_TYPE.Pear,
			'position': [
				Vector2(-23, -11),
				Vector2(-21, -1),
				Vector2(13, -4),
			],
		},
		'peach': {
			'type': Constants.FRUIT_TYPE.Peach,
			'position': [
				Vector2(-22, -9),
				Vector2(-19, 0),
				Vector2(13, -4),
			],
		},
	}
func _ready():
	do_animation(
		func fruit_tween_callback():
			Events.harvest_fruit.emit(type)
			queue_free()
	)

func set_fruit_data(fruit_type, index: int):
	position = fruit_data[fruit_type]['position'][index]
	type = fruit_data[fruit_type]['type']
	frame = {
		Constants.FRUIT_TYPE.Apple: 0,
		Constants.FRUIT_TYPE.Orange: 1,
		Constants.FRUIT_TYPE.Peach: 2,
		Constants.FRUIT_TYPE.Pear: 3,
		Constants.FRUIT_TYPE.None: 4,
	}[type]
