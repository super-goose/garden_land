extends Node

const TILE_SIZE = 16

const WHOLE_TILE_CELL = Vector2i(LevelGenerationUtil.TILE_SIZE, LevelGenerationUtil.TILE_SIZE)
const HALF_TILE_CELL = Vector2i(LevelGenerationUtil.TILE_SIZE / 2, LevelGenerationUtil.TILE_SIZE / 2)


const HILL_PROBABILITY_COEFFICIENT = 40 # 70 was original value
const HILL_AMOUNT_COEFFICIENT = 10 # 30 was original value
const TREE_COEFFICIENT = 5 # 20 was original value


var temp_width : int
var temp_height : int
const PERCENT_WATER = 45
var hill_terrain_array = []
var grass_terrain_array = []
var walkable_tiles = []
var tree_locations = []
var plantable_tiles = []

###
### Level Generation
###

""" randomly generate a map, defined by true (land) and false (not land) values """
func generate_map_matrix(world_width: int, world_height: int) -> void:
	# half the original map size to get the working map size
	temp_width = int(world_width / 2)
	temp_height = int(world_height / 2)

	# refine and reshape a set of randomly assigned cells (true = land, false = water)
	var map_matrix = generate_base_random_matrix()
	map_matrix = congeal_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = remove_puddles(map_matrix)

	# add hills to the shores and to (100 - HPC) percent of the middle, then remove HAC percent of those
	var half_hills = generate_hills(map_matrix, HILL_PROBABILITY_COEFFICIENT, HILL_AMOUNT_COEFFICIENT)
	for v in half_hills:
		var new_x = v.x * 2
		var new_y = v.y * 2
		
		hill_terrain_array.push_front(Vector2i(new_x, new_y))
		hill_terrain_array.push_front(Vector2i(new_x + 1, new_y))
		hill_terrain_array.push_front(Vector2i(new_x, new_y + 1))
		hill_terrain_array.push_front(Vector2i(new_x + 1, new_y + 1))

	# double the working map size to fit the original map
	var expanded_matrix = expand_map_matrix(map_matrix)
	_iterate_through_matrix(
		expanded_matrix,
		func (cell, x, y):
			if cell:
				var v = Vector2i(x, y)
				grass_terrain_array.push_front(v)
				if hill_terrain_array.find(v) == -1:
					walkable_tiles.push_front(v)
	)
	
	# generate and place trees here
	tree_locations = generate_tree_locations(TREE_COEFFICIENT)

func generate_tree_locations(tree_coefficient: int):
	var tiles = []
	for cell in walkable_tiles:
		var near_edge = walkable_tiles.find(Vector2i(cell.x, cell.y + 1)) == -1 or walkable_tiles.find(Vector2i(cell.x, cell.y - 1)) == -1 or walkable_tiles.find(Vector2i(cell.x + 1, cell.y)) == -1 or walkable_tiles.find(Vector2i(cell.x - 1, cell.y)) == -1
		var near_other_tree = (
			tiles.find(Vector2i(cell.x, cell.y + 1)) > -1 or
			tiles.find(Vector2i(cell.x, cell.y - 1)) > -1 or
			tiles.find(Vector2i(cell.x + 1, cell.y)) > -1 or
			tiles.find(Vector2i(cell.x - 1, cell.y)) > -1 or

			tiles.find(Vector2i(cell.x + 1, cell.y + 1)) > -1 or
			tiles.find(Vector2i(cell.x - 1, cell.y - 1)) > -1 or
			tiles.find(Vector2i(cell.x + 1, cell.y - 1)) > -1 or
			tiles.find(Vector2i(cell.x - 1, cell.y + 1)) > -1
		)
		if not near_edge and not near_other_tree:
			if Dice.roll_d100() < tree_coefficient:
				tiles.push_front(cell)
	return tiles

""" take the halved matrix and restore its size to the original map size """
func expand_map_matrix(matrix):
	var expanded_map_matrix = []
	for column in matrix:
		var expanded_column = []
		for cell in column:
			expanded_column.push_front(cell)
			expanded_column.push_front(cell)
		expanded_map_matrix.push_front(expanded_column)
		expanded_map_matrix.push_front(expanded_column)
	return expanded_map_matrix

""" generate a random matrix to start with """
func generate_base_random_matrix():
	var matrix = []
	for x in range(0, temp_width):
		var column = []
		for y in range(0, temp_height):
			var is_in_the_middle = (
				Common.between((temp_height / 2) - (temp_height / 20), (temp_height / 2) + (temp_height / 20), y)
				if temp_height > temp_width else
				Common.between((temp_width / 2) - (temp_width / 20), (temp_width / 2) + (temp_width / 20), x)
			)
			var should_be_land = Dice.rng.randi_range(1, 100) > (85 if is_in_the_middle else PERCENT_WATER)
			column.push_front(should_be_land)
		matrix.push_front(column)
	return matrix

""" determine if this square is part of a puddle (2x2 square of water surrounded by land) """
func _is_puddle(matrix, x, y):
	var is_puddle_horizontally = (
		matrix[x - 1][y] and !matrix[x][y] and !matrix[x + 1][y] and matrix[x + 2][y]
	) or (
		matrix[x - 2][y] and !matrix[x - 1][y] and !matrix[x][y] and matrix[x + 1][y]
	)
	var is_puddle_vertically = (
		matrix[x][y - 1] and !matrix[x][y] and !matrix[x][y + 1] and matrix[x][y + 2]
	) or (
		matrix[x][y - 2] and !matrix[x][y - 1] and !matrix[x][y] and matrix[x][y + 1]
	)
	return is_puddle_horizontally and is_puddle_vertically

""" if this cell is part of a puddle, make it be land """
func remove_puddles(matrix):
	return _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if x < 2 or y < 2 or x > temp_width - 3 or y > temp_height - 3:
				return cell
			if !cell and _is_puddle(matrix, x, y):
				return true
			return cell
	)

""" remove single cells surrounded by opposite cell type """
func congeal_map(matrix):
	return _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if x == 0 or y == 0 or x == temp_width - 1 or y == temp_height - 1:
				return false
			if !cell:
				if matrix[x + 1][y] and matrix[x - 1][y] and matrix[x][y + 1] and matrix[x][y - 1]:
					return true
				if !matrix[x + 1][y] and !matrix[x - 1][y] and !matrix[x][y + 1] and !matrix[x][y - 1]:
					return false
			return cell
	)

""" if land is flanked by water, make it water as well """
func sparsify_map(matrix):
	return _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if x == 0 or y == 0 or x == temp_width - 1 or y == temp_height - 1:
				return false
			if cell:
				if (!matrix[x + 1][y] and !matrix[x - 1][y]) or (!matrix[x][y + 1] and !matrix[x][y - 1]):
					return false
			return cell
	)

""" if water is flanked by land, make it land as well """
func fillify_map(matrix):
	return _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if x == 0 or y == 0 or x == temp_width - 1 or y == temp_height - 1:
				return false
			if !cell:
				if (matrix[x + 1][y] and matrix[x - 1][y]) or (matrix[x][y + 1] and matrix[x][y - 1]):
					return true
			return cell
	)

""" for each item in the provided matrix, perform the provided operation """
func _iterate_through_matrix(matrix, operation):
	var new_matrix = []
	for x in range(0, matrix.size()):
		var column = []
		for y in range(0, matrix[x].size()):
			column.push_front(operation.call(matrix[x][y], x, y))
		new_matrix.push_front(column)
	return new_matrix

""" hills around the shores and X% inland pared down to X% and then single hill pieces removed """
func generate_hills(matrix: Array, hill_probability_coefficient: int, hill_amount_coefficient: int):
	var hill_coords = []
	var final_hill_array = []

	var new_matrix = _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if cell:
				if !matrix[x + 1][y] || !matrix[x - 1][y] || !matrix[x][y + 1] || !matrix[x][y - 1]:
					hill_coords.push_front(Vector2i(x, y))
					return true
				elif Dice.roll_d100() < hill_probability_coefficient:
					hill_coords.push_front(Vector2i(x, y))
					return true
			return false
	)
	var hill_cells_to_remove = [];
	var target_number_of_cells = int(hill_coords.size() * hill_amount_coefficient / 100)
	while hill_coords.size() > target_number_of_cells:
		var index = Dice.roll_dn(hill_coords.size()) - 1
		hill_cells_to_remove.push_front(hill_coords[index])
		hill_coords.remove_at(index)
#
	for v in hill_cells_to_remove:
		new_matrix[v.x][v.y] = false
#
	var final_matrix = _iterate_through_matrix(
		new_matrix,
		func(cell, x, y):
			if cell and (new_matrix[x + 1][y] or new_matrix[x - 1][y] or new_matrix[x][y + 1] or new_matrix[x][y - 1]):
				final_hill_array.push_front(Vector2i(x, y))
			return cell
	)

	return final_hill_array

###
### Pathfinding
###

#var level = []
#var max_x : int
#var max_y : int
#
#func load_level(level_name, level_navigation_grid):
#	level = level_navigation_grid
#	max_x = level[0].size() - 1
#	max_y = level.size() - 1

func find_first_step(here, there):
	var path = find_path(here, there, {})
	if path.size() == 0:
		return there if can_go_to(there) else here
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

func find_path(here: Vector2, there: Vector2, options: Dictionary):
	var dominant_direction = calculate_dominant_direction(here, there, options)
	var next_to_there = there + {
		'up': Vector2.DOWN,
		'down': Vector2.UP,
		'left': Vector2.RIGHT,
		'right': Vector2.LEFT,
	}[dominant_direction]
	var path = a_star(here, next_to_there)
	path.pop_front()
	return {
		'path': path,
		'direction': dominant_direction,
	}

func can_go_to(p : Vector2):
	var p_i = Vector2i(p)
	return walkable_tiles.has(p_i) and not tree_locations.has(p_i)

func vec_to_str(v : Vector2) -> String:
	return "%s,%s" % [v.x, v.y]

func str_to_vec(s : String) -> Vector2:
	var c = s.split(',')
	return Vector2(int(c[0]), int(c[1]))

func construct_path(current : String, cameFrom : Dictionary):
	var path = [str_to_vec(current)]
	while cameFrom.has(current):
		path.push_front(str_to_vec(cameFrom[current]))
		current = cameFrom[current]
	return path

func lowest_in_set(s : Dictionary):
	var points = s.keys()
	if points.size() == 1:
		return points[0]

	var current = null
	var length = INF
	for p in points:
		if s[p] < length:
			current = p
			length = s[p]

	return current

func get_neighbors(p : Vector2):
	var can_go_up = can_go_to(p + Vector2.UP)
	var can_go_down = can_go_to(p + Vector2.DOWN)
	var can_go_left = can_go_to(p + Vector2.LEFT)
	var can_go_right = can_go_to(p + Vector2.RIGHT)
	var can_go_up_left = can_go_to(p + Vector2.UP + Vector2.LEFT) and can_go_up and can_go_left
	var can_go_up_right = can_go_to(p + Vector2.UP + Vector2.RIGHT) and can_go_up and can_go_right
	var can_go_down_left = can_go_to(p + Vector2.DOWN + Vector2.LEFT) and can_go_down and can_go_left
	var can_go_down_right = can_go_to(p + Vector2.DOWN + Vector2.RIGHT) and can_go_down and can_go_right

	var neighbors = []

	if can_go_up_left:
		neighbors.push_back(p + Vector2.UP + Vector2.LEFT)
	if can_go_up:
		neighbors.push_back(p + Vector2.UP)
	if can_go_up_right:
		neighbors.push_back(p + Vector2.UP + Vector2.RIGHT)
	if can_go_right:
		neighbors.push_back(p + Vector2.RIGHT)
	if can_go_down_right:
		neighbors.push_back(p + Vector2.DOWN + Vector2.RIGHT)
	if can_go_down:
		neighbors.push_back(p + Vector2.DOWN)
	if can_go_down_left:
		neighbors.push_back(p + Vector2.DOWN + Vector2.LEFT)
	if can_go_left:
		neighbors.push_back(p + Vector2.LEFT)

	return neighbors

func a_star(here: Vector2, there: Vector2):
	if not can_go_to(there):
		return []

	var closedSet = {}
	var cameFrom = {}
	var openSet = {}
	var gScore = {}
	var start = vec_to_str(here)
	openSet[start] = here.distance_to(there)
	gScore[start] = 0

	while not openSet.is_empty():
		var current = lowest_in_set(openSet)
		var currentVector = str_to_vec(current)
		
		# we made it!
		if currentVector.x == there.x and currentVector.y == there.y:
			return construct_path(current, cameFrom)
		
		openSet.erase(current)
		closedSet[current] = true

		if not can_go_to(currentVector):
			continue

		for neighbor in get_neighbors(currentVector):
			var nStr = vec_to_str(neighbor)
			if not closedSet.has(nStr):
				var tempGScore = gScore[current] + 1
				
				if not gScore.has(nStr) or not tempGScore >= gScore[nStr]:
					cameFrom[nStr] = current
					gScore[nStr] = tempGScore
					openSet[nStr] = tempGScore + neighbor.distance_to(there)
	return []
