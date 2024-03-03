extends Node2D

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_position = $Level.get_start_position()
	$Character.set_start_position(start_position)
	Events.time_passage_pause.connect(_handle_event_time_passage_pause)
	Events.time_passage_play.connect(_handle_event_time_passage_unpause)
	Events.time_passage_fast_forward.connect(_handle_event_time_passage_unpause)

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

func _process(delta):
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
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT): # left
			var destination = get_global_mouse_position()
			destination = Common.convert_to_grid_coordinates(destination)
			print('go to: %s' % destination)
			$Character.go_to_position(destination)

