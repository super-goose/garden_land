extends CanvasLayer

@onready var actions_container = $MarginContainer/ColorRect/ColorRect/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	print('connecting hud stuff')
	Events.set_actions.connect(handle_set_actions)


func handle_set_actions(actions: Array[Constants.ACTIONS]):
	print('display the correct actions')
	for child in actions_container.get_children():
		child.visible = actions.has(child.action)
			
