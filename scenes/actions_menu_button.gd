class_name ActionsMenuButton
extends TextureButton

@export var action: Constants.ACTIONS
var action_image

func _ready():
	action_image = {
		Constants.ACTIONS.Hoe: load("res://modified-assets/tools/tools-hoe.png"),
		Constants.ACTIONS.Water: load("res://modified-assets/tools/tools-water-can.png"),
		Constants.ACTIONS.Chop: load("res://modified-assets/tools/tools-axe.png"),
		Constants.ACTIONS.Sow: load("res://modified-assets/tools/farm-plant-items-0.png"),
	}
	$TextureRect.texture = action_image[action]

func _on_pressed():
	Events.perform_action.emit(action)
