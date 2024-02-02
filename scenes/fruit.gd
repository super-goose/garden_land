class_name Fruit
extends Sprite2D

var direction: float
var type: Constants.FRUIT_TYPE

func _ready():
#	do_animation()
	pass

func do_animation():
	var new_position = LevelGenerationUtil.TILE_SIZE * 1.5 * Vector2.RIGHT.rotated(direction)
	var t = get_tree().create_tween()
	var duration = .2
	t.tween_property(self, 'position', new_position, duration)

	await get_tree().create_timer(.3).timeout

	t.tween_property(self, 'position', new_position * .5, duration)

func set_fruit_data(fruit_data: Dictionary, index: int):
	position = fruit_data['position'][index]
	type = fruit_data['type']
	frame = {
		Constants.FRUIT_TYPE.Apple: 0,
		Constants.FRUIT_TYPE.Orange: 1,
		Constants.FRUIT_TYPE.Peach: 2,
		Constants.FRUIT_TYPE.Pear: 3,
		Constants.FRUIT_TYPE.None: 4,
	}[type]
