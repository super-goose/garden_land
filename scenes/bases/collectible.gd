class_name Collectible
extends Sprite2D

func do_animation(callback: Callable):
	await get_tree().create_timer(1).timeout
	var character_global_position = Common.convert_from_grid_coordinates(Common.character_position) #- Vector2(LevelGenerationUtil.HALF_TILE_CELL)

	var new_position = position + to_local(character_global_position) + Vector2(LevelGenerationUtil.HALF_TILE_CELL)
	var t = get_tree().create_tween()
	var duration = .2
	t.tween_property(self, 'position', new_position, duration)
	t.tween_callback(callback)
