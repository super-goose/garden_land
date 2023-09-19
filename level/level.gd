extends Node2D

@export var generate_random_map = true
@export var world_width = 60
@export var world_height = 100

const LAYER_WATER = 0
const LAYER_GRASS = 1
const LAYER_DIRT = 2
const LAYER_ROCKS_AND_STUFF = 3
const LAYER_HILL = 4
const LAYER_HILL_BUSHES = 5

func _ready():
	if generate_random_map:
		generate_said_random_map()

func generate_said_random_map():
	# clears the tilemap
	$TileMap2.clear()
	var map_matrix = $Util.generate_map_matrix(world_width, world_height)
	var grass_terrain_array = []

	# fills the tilemap water layer with water
	for x in range(0, world_width):
		for y in range(0, world_height):
			$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(Dice.rng.randi_range(0, 3) , 0))
			if map_matrix[x][y]:
				grass_terrain_array.push_front(Vector2i(x, y))
	$TileMap2.set_cells_terrain_connect(LAYER_GRASS, grass_terrain_array, 0, 0)
