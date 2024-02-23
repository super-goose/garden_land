extends MarginContainer

@export var title: String = ''
signal close_button_pressed

func _ready():
	$HBoxContainer/MarginContainer/Label.text = title

func _on_close_button_pressed():
	close_button_pressed.emit()
