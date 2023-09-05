extends Node2D

@export var generate_random_map = true
@export var world_width = 60
@export var world_height = 100
@export var number_of_rectangles = 10

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

	# fills the tilemap water layer with water
	for x in range(-int(world_width / 2), int(world_width / 2)):
		for y in range(-int(world_height / 2), int(world_height / 2)):
			$TileMap2.set_cell(LAYER_WATER, Vector2i(x, y), 2, Vector2i(Dice.rng.randi_range(0, 3) , 0))

