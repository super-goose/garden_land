extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var start_x = int($Level.world_width / 2)
	var start_y = int($Level.world_height / 2)
	
	print("start position should be: (%s, %s)" % [start_x, start_y])
	$Character.set_start_position(Vector2i(start_x, start_y))

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
