extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
