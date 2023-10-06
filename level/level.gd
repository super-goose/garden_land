extends Node2D

@export var generate_random_map = true
@export var world_width = 60
@export var world_height = 100
@export var hill_coefficient = 70

const LAYER_WATER = 0
const LAYER_GRASS = 1
const LAYER_DIRT = 2
const LAYER_ROCKS_AND_STUFF = 3
const LAYER_HILL = 4
const LAYER_HILL_BUSHES = 5

var map_generated = false

func _ready():
	if generate_random_map:
		generate_said_random_map()

func generate_said_random_map():
	# clears the tilemap
	$TileMap2.clear()
	$Util.generate_map_matrix(world_width, world_height)

	# fills the tilemap water layer with water
	for x in range(0, world_width):
		for y in range(0, world_height):
			if $Util.grass_terrain_array.find(Vector2i(x, y)) > -1:
				$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(3 , 0))
			else:
				$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(Dice.rng.randi_range(0, 2) , 0))
	$TileMap2.set_cells_terrain_connect(LAYER_GRASS, $Util.grass_terrain_array, 0, 0)
	
	print(world_width)
	print(world_height)
#	print(hill_terrain_array)
#	$TileMap2.set_cells_terrain_connect(LAYER_HILL, hill_terrain_array, 0, 3)
	$TileMap2.set_cells_terrain_connect(LAYER_HILL_BUSHES, $Util.hill_terrain_array, 0, 2)
	map_generated = true


func get_start_position() -> Vector2i:
#	if not map_generated:
#		generate_said_random_map()
	return $Util.walkable_tiles[Dice.roll_dn($Util.walkable_tiles.size()) - 1]
#	return Vector2i.ZERO
	
