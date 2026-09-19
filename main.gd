extends Node2D

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_position = $Level.get_start_position()
	$Character.set_start_position(start_position)
	Events.time_passage_pause.connect(_handle_event_time_passage_pause)
	Events.time_passage_play.connect(_handle_event_time_passage_unpause)
	Events.time_passage_fast_forward.connect(_handle_event_time_passage_unpause)
	Events.character_move_to_testing_grounds.connect(_handle_character_move_to_testing_grounds)
	State.reload_game.connect(_handle_state_reload_game)

func _handle_state_reload_game():
	get_tree().reload_current_scene()

func _handle_event_time_passage_pause():
	$WeatherLayer.process_mode = Node.PROCESS_MODE_DISABLED
	$Level.process_mode = Node.PROCESS_MODE_DISABLED
	$Character.process_mode = Node.PROCESS_MODE_DISABLED
	is_paused = true

func _handle_event_time_passage_unpause():
	$WeatherLayer.process_mode = Node.PROCESS_MODE_ALWAYS
	$Level.process_mode = Node.PROCESS_MODE_ALWAYS
	$Character.process_mode = Node.PROCESS_MODE_ALWAYS
	is_paused = false

func _process(_delta):
	if Input.is_action_just_pressed("utility_reload"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused

func _unhandled_input(event: InputEvent) -> void:
	if is_paused:
		return
	if event is InputEventMouseButton: # mouse click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and not is_in_test_location: # left
			var destination = get_global_mouse_position()
			destination = Common.convert_to_grid_coordinates(destination)
			print('go to: %s' % destination)
			$Character.go_to_position(destination)

var is_in_test_location = false
var character_direction
func _handle_character_move_to_testing_grounds():
	var offset = Vector2i(8, 8)
	if is_in_test_location:
		$Character.position = State.garden_data.start_location * 16
		is_in_test_location = false
		$Character.set_direction(character_direction)
		$WeatherLayer.rain_enabled = true
	else:
		character_direction = $Character.direction
		$Character.set_direction('down')
		$Character.position = (Vector2i(7, 68) * 16) + offset
		is_in_test_location = true
		$WeatherLayer.rain_enabled = false
		Events.set_action_tutorial.emit("hoeing around")
