extends Node

var temp_width : int
var temp_height : int
const PERCENT_WATER = 45

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
	for x in range(0, matrix.size()):
		for y in range(0, matrix[x].size()):
			matrix[x][y] = operation.call(matrix[x][y], x, y)
	return matrix

func generate_hills(matrix):
	pass
"""
  const addHills = (map) => {
	const mapToHill = clone(map);
	// select a few spots to add hills
	const hillCells = [];
	const hills = mapToHill.map((column, x) => {
	  return column.map((cell, y) => {
		if (cell) {
		  if (!mapToHill[x + 1][y] || !mapToHill[x - 1][y] || !mapToHill[x][y + 1] || !mapToHill[x][y - 1]) {
			hillCells.push({ x, y })
			return true;
		  }
		  hillCells.push({ x, y })
		  return Math.random() > .7;
		}

		return false;
	  });
	});

	const targetNumberOfHillCells = hillCells.length * .7;
	const hillCellsToRemove = [];
	while (hillCells.length > targetNumberOfHillCells) {
	  hillCellsToRemove.push(hillCells.splice(Math.floor(Math.random() * hillCells.length), 1)[0]);
	}

	hillCellsToRemove.forEach(({ x, y }) => {
	  hills[x][y] = false;
	})

	const paredDownHills = hills.map((column, x) => {
	  return column.map((cell, y) => {
		if (cell) {
		  if (hills[x + 1][y] || hills[x - 1][y] || hills[x][y + 1] || hills[x][y - 1]) {
			return true;
		  }
		}

		return false;
	  });
	});

	return paredDownHills
  }

"""
