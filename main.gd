extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_position = $Level.get_start_position()
	
#	print("start position should be: %s" % start_position)
	$Character.set_start_position(start_position)

func _process(delta):
	if Input.is_action_just_pressed("utility_reload"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

#	if (Input.is_action_just_pressed("restart")):
#		get_tree().reload_current_scene()
#
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton: # mouse click
		if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT): # left
			var destination = get_global_mouse_position()
			destination = Common.convert_to_grid_coordinates(destination)
#			print('go to: (%s, %s)' % [destination.x, destination.y])
			$Character.go_to_position(destination)

