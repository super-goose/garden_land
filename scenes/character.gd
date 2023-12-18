@icon("res://meta/assets/character.png")
extends CharacterBody2D

const SPEED = 60
const HOE_LIMIT = 2

var times_hoed = 0
var state = 'idle'
var direction = 'down'
var current_plant: GardenPlot
var current_tree: FruitTree
var watering_happened = false

@export var start_position : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	position = (start_position * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL
	Events.select_garden_plot.connect(_handle_event_select_garden_plot)
	Events.select_fruit_tree.connect(_handle_event_select_fruit_tree)
	Events.perform_action.connect(_handle_event_perform_action)
func set_start_position(v: Vector2i):
	start_position = v
	position = (start_position * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input(delta)
	play_state_animation()
	process_state_action()
#	position_focus_indicator()

func process_state_action():
	pass

func handle_input(delta):
	if Input.is_action_pressed("water"):
		state = "water"
		return

	watering_happened = false
	$AnimatedWater.visible = false

	if Input.is_action_just_pressed("hoe"):
		handle_hoeing()
	
	if Input.is_action_pressed("chop"):
		state = "chop"
		return

func handle_hoeing():
	if not current_tree:
		state = "hoe"



func play_state_animation():
	var animation_name = "%s_%s" % [state, direction]
#	print('play_state_animation %s' % animation_name)
	$AnimatedSprite2D.play(animation_name)
	if state == 'water' and direction != 'up':
		$AnimatedWater.visible = true
		$AnimatedWater.play('water_%s' % direction)

#func position_focus_indicator():
#	var focus_coords = LevelGenerationUtil.convert_to_grid_coordinates($AoI/FocusCursor.global_position)
#	$Focus.global_position = focus_coords * LevelGenerationUtil.TILE_SIZE

func position_to_coords(p: Vector2) -> Vector2i:
	return Vector2i((p - Vector2(LevelGenerationUtil.HALF_TILE_CELL)) / LevelGenerationUtil.TILE_SIZE)

func coords_to_position(p: Vector2i) -> Vector2:
	return (p * LevelGenerationUtil.TILE_SIZE) + LevelGenerationUtil.HALF_TILE_CELL

var path = []
var final_direction

func go_to_position(destination: Vector2i, options: Dictionary = {}):
	if current_plant:
		current_plant.hide_actions()
	state = 'walk'
	var here = position_to_coords(position)
	var path_data = LevelGenerationUtil.find_path(here, destination, options)
	path = path_data['path']
	final_direction = path_data['direction']
	print('Character should go to: %s' % destination)
	print(path)
	print(direction)
	go_to_next_position()

func go_to_next_position():
	var coord = path.pop_front()
	if not coord:
		set_direction(final_direction)
		state = 'idle'
		return
	move_to(coord)

func move_to(p: Vector2i):
	# TODO: move until the focus is here, not the character
	var new_position = coords_to_position(p)
	var t = get_tree().create_tween()
	var duration = .5 * (Vector2(new_position).distance_to(position) / LevelGenerationUtil.TILE_SIZE)
	state = 'walk'
	_set_direction_from_vectors(position, new_position)
	t.tween_property(self, 'position', new_position, duration)
	t.tween_callback(go_to_next_position)

func _set_direction_from_vectors(from: Vector2, to: Vector2):
	if from.y > to.y:
		set_direction('up')

	if from.x > to.x:
		set_direction('left')

	if from.x < to.x:
		set_direction('right')

	if from.y < to.y:
		set_direction('down')
	

func set_direction(d):
	direction = d

	var r = {
		"up": 0,
		"down": PI,
		"right": PI / 2,
		"left": PI * 1.5,
	}[direction]
	$AoI.rotation = r


func _on_ao_i_area_entered(area):
	if area is GardenPlot:
		current_plant = area
	elif area is FruitTree:
		current_tree = area

func _on_ao_i_area_exited(area):
	if current_plant == area:
		current_plant = null
	if current_tree == area:
		current_tree = null


func _on_animated_water_animation_finished():
	$AnimatedWater.visible = false


func _on_animated_sprite_2d_animation_looped():
	if state == 'chop' and current_tree:
		current_tree.get_chopped()
	elif state == 'hoe' and not current_tree:
		times_hoed += 1
		if times_hoed == HOE_LIMIT:
			times_hoed = 0
			var coordinates = LevelGenerationUtil.convert_to_grid_coordinates($AoI/FocusCursor.global_position)
			LevelGenerationUtil.add_plantable_tile(coordinates)
			state = 'idle'


func _on_animated_sprite_2d_animation_finished():
	if state == 'water' and current_plant:
		if not watering_happened:
			current_plant.increase_stage()
			watering_happened = true

func _handle_event_select_garden_plot(garden_plot: GardenPlot):
	var here = position_to_coords(position)
	var garden_plot_coordinates = LevelGenerationUtil.convert_to_grid_coordinates(garden_plot.position)
	print(here)
	print(garden_plot_coordinates)
	print(Vector2(here).distance_to(garden_plot_coordinates))
	if Vector2(here).distance_to(garden_plot_coordinates) == 1:
		print('open the garden plot menu')
	go_to_position(garden_plot_coordinates)

func _handle_event_select_fruit_tree(fruit_tree: FruitTree):
	var here = position_to_coords(position)
	var fruit_tree_coordinates = LevelGenerationUtil.convert_to_grid_coordinates(fruit_tree.position)
	if Vector2(here).distance_to(fruit_tree_coordinates) == 1:
		print('open the fruit tree menu')
	go_to_position(fruit_tree_coordinates, { 'avoid': 'down' })

func _handle_event_perform_action(action: Constants.ACTIONS):
	if action == Constants.ACTIONS.Chop:
		print('chop')
	if action == Constants.ACTIONS.Water:
		print('water')
	if action == Constants.ACTIONS.Hoe:
		print('hoe')
	if action == Constants.ACTIONS.Sow:
		print('sow')
	print(current_plant)

func _on_button_pressed():
	if current_plant:
		current_plant.display_actions()
		
