@tool
extends MarginContainer

@export var title: String = ''
@export var show_settings: bool = true
@export var show_close: bool = true
@export var smaller_text: bool = false

signal close_button_pressed
signal settings_button_pressed

func _ready():
	$HBoxContainer/MarginContainer/Label.text = title
	$HBoxContainer/MarginContainer2/SettingsButton.visible = show_settings
	$HBoxContainer/MarginContainer2/CloseButton.visible = show_close
	$HBoxContainer/MarginContainer/Label.add_theme_font_size_override("font_size", 24 if smaller_text else 36)

func _on_close_button_pressed():
	close_button_pressed.emit()

func _on_settings_button_pressed():
	settings_button_pressed.emit()
