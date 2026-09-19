class_name PopoverDialogue
extends Control

var label_text: String

static func create_and_set_text(text: String) -> PopoverDialogue:
	# Replace this with the EXACT path to your .tscn file!
	var scene = load("res://scenes/ui_components/popover_dialogue.tscn")
	var instance = scene.instantiate() as PopoverDialogue
	instance.label_text = text
	return instance

func _ready():
	$MarginContainer/NinePatchRect/MarginContainer/Label.text = label_text
