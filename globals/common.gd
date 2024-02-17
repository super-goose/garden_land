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

func union(arrays: Array) -> Array:
	var final_dict = {}
	for array in arrays:
		for element in array:
			final_dict[element] = true
	return final_dict.keys()

func convert_to_grid_coordinates(v: Vector2) -> Vector2i:
	var cx = -1 if v.x < 0 else 0
	var cy = -1 if v.y < 0 else 0
	var x = int(v.x / LevelGenerationUtil.TILE_SIZE)
	var y = int(v.y / LevelGenerationUtil.TILE_SIZE)
	return Vector2i(x + cx, y + cy)

func convert_from_grid_coordinates(v: Vector2i) -> Vector2:
	var x = int(v.x * LevelGenerationUtil.TILE_SIZE)
	var y = int(v.y * LevelGenerationUtil.TILE_SIZE)
	return Vector2(x, y)

func get_color(r, g, b, a):
	var new_r = r / 255.0
	var new_g = g / 255.0
	var new_b = b / 255.0
	var new_a = a / 255.0

	return Color(new_r, new_g, new_b, new_a)
