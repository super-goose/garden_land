extends Node

# I'm gonna hate myself in the future
var character_position: Vector2i

func between(min: float, max: float, num: float) -> bool:
	return min < num and num < max

func is_subset(complete: Array, to_check: Array) -> bool:
	for e in to_check:
		if not complete.has(e):
			return false

	return true

func convert_to_grid_coordinates(v: Vector2) -> Vector2i:
	var x = int(v.x / LevelGenerationUtil.TILE_SIZE)
	var y = int(v.y / LevelGenerationUtil.TILE_SIZE)
	return Vector2i(x, y)

func convert_from_grid_coordinates(v: Vector2i) -> Vector2:
	var x = int(v.x * LevelGenerationUtil.TILE_SIZE)
	var y = int(v.y * LevelGenerationUtil.TILE_SIZE)
	return Vector2(x, y)
