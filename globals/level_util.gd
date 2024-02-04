#class_name LevelUtil
extends Node

var directions = [
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.RIGHT,
	Vector2i.UP + Vector2i.LEFT,
	Vector2i.UP + Vector2i.RIGHT,
	Vector2i.DOWN + Vector2i.LEFT,
	Vector2i.DOWN + Vector2i.RIGHT,
]

@onready var a_star = AStar2D.new()
# LIMITATION: if the map extends to the left or above of -1000, -1000,
# that might throw off the reliability of this function
# CONCEPT: id = xxxxxyyyyy
func vector_to_a_star_id(v: Vector2i):
	var _x = v.x + 1000
	var _y = v.y + 1000
	return _x * 10000 + _y

func a_star_id_to_vector(id: int):
	var _x = int(id / 10000)
	var _y = id % 10000
	return Vector2i(_x - 1000, _y - 1000)



func set_up_a_star(tilemap: TileMap, included_layers: Array[int], excluded_layers: Array[int]):
	a_star.clear()

	var excluded_sets = excluded_layers.map(
		func excluded_cells_from_layer_map(layer):
			return tilemap.get_used_cells(layer)
	)

	var excluded_set = Common.union(excluded_sets)

#	print(excluded_set)

	for i in range(included_layers.size()):
		# using the index here, allows us to give different
		# weights to different cells, for preference in a* alg
		var cells = tilemap.get_used_cells(included_layers[i])
		for cell in cells:
#			if cell == Vector2i(3, -8):
#				breakpoint
			if cell not in excluded_set:
				var a_s_id = vector_to_a_star_id(cell)
				a_star.add_point(a_s_id, cell, .1 * i) # TODO: check weight

	var point_ids = a_star.get_point_ids()
	for id in point_ids:
		var c = a_star_id_to_vector(id)
		for d in directions:
			var d_id = vector_to_a_star_id(c + d)
			if d_id in point_ids:
				a_star.connect_points(id, d_id)

func _are_connected(here, there):
	return a_star.are_points_connected(vector_to_a_star_id(here), vector_to_a_star_id(there))

func find_first_step(here, there):
	var path = find_path(here, there, {})
	if path.size() == 0:
		return there if _are_connected(here, there) else here
	return path[0]

func calculate_dominant_direction(here: Vector2, there: Vector2, options: Dictionary):
	var direction_to_avoid = null
	if options.has('avoid'):
		direction_to_avoid = options['avoid']

	if abs(here.x - there.x) > abs(here.y - there.y) or direction_to_avoid in ['up', 'down']: # l or r
		if here.x < there.x:
			return 'right'
		else:
			return 'left'
	elif abs(here.x - there.x) < abs(here.y - there.y): # u or d
		if here.y < there.y:
			return 'down'
		else:
			return 'up'
	else: # diagonally
		if here.y < there.y:
			return 'down'
		else:
			return 'up'

func _get_path(here, there):
	var here_id = vector_to_a_star_id(here)
	var there_id = vector_to_a_star_id(there)
	var are_connected = a_star.are_points_connected(here_id, there_id)
#	breakpoint
	print(are_connected)
	return Array(a_star.get_id_path(here_id, there_id)).map(
		func get_path_map(id):
			return a_star_id_to_vector(id)
	)

func find_path(here: Vector2, there: Vector2, options: Dictionary):
	var dominant_direction = calculate_dominant_direction(here, there, options)
	var next_to_there = there + {
		'up': Vector2.DOWN,
		'down': Vector2.UP,
		'left': Vector2.RIGHT,
		'right': Vector2.LEFT,
	}[dominant_direction]
	var path = _get_path(here, next_to_there)
	path.pop_front()
	return {
		'path': path,
		'direction': dominant_direction,
	}

