class_name Fruit
extends Sprite2D

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
	do_animation()

func do_animation():
	await get_tree().create_timer(1).timeout
#	breakpoint
	var character_global_position = Common.convert_from_grid_coordinates(Common.character_position) #- Vector2(LevelGenerationUtil.HALF_TILE_CELL)
#	var current_position = position
	var new_position = position + to_local(character_global_position) + Vector2(LevelGenerationUtil.HALF_TILE_CELL)
	print('Common.character_position: %s' % Common.convert_from_grid_coordinates(Common.character_position))
	print('fruit position: %s' % position)
	print('fruit new_position: %s' % new_position)
	var t = get_tree().create_tween()
	var duration = .2
	t.tween_property(self, 'position', new_position, duration)
	Events.harvest_fruit.emit(type)
	t.tween_callback(queue_free)

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
