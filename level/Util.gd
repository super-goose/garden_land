extends Node

var temp_width : int
var temp_height : int
const PERCENT_WATER = 45
var hills = []

""" randomly generate a map, defined by true (land) and false (not land) values """
func generate_map_matrix(world_width: int, world_height: int) -> Array:
	temp_width = int(world_width / 2)
	temp_height = int(world_height / 2)
	
	var map_matrix = generate_base_random_matrix()
	map_matrix = congeal_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = fillify_map(map_matrix)
	map_matrix = sparsify_map(map_matrix)
	map_matrix = remove_puddles(map_matrix)

	var half_hills = generate_hills(map_matrix, 70)
	for v in half_hills:
		var new_x = v.x * 2
		var new_y = v.y * 2
		
		hills.push_front(Vector2i(new_x, new_y))
		hills.push_front(Vector2i(new_x + 1, new_y))
		hills.push_front(Vector2i(new_x, new_y + 1))
		hills.push_front(Vector2i(new_x + 1, new_y + 1))

	return expand_map_matrix(map_matrix)

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
func generate_hills(matrix: Array, hill_coefficient: int):
	var hill_coords = []
	var final_hill_array = []

	var new_matrix = _iterate_through_matrix(
		matrix,
		func(cell, x, y):
			if cell:
				if !matrix[x + 1][y] || !matrix[x - 1][y] || !matrix[x][y + 1] || !matrix[x][y - 1]:
					hill_coords.push_front(Vector2i(x, y))
					return true
				elif Dice.roll_d100() > hill_coefficient:
					hill_coords.push_front(Vector2i(x, y))
					return true
			return false
	)
	var hill_cells_to_remove = [];
	var target_number_of_cells = int(hill_coords.size() * hill_coefficient / 100)
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
