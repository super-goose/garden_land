extends MarginContainer

@export var title: String = ''
@export var show_settings = true
signal close_button_pressed
signal settings_button_pressed

func _ready():
	$HBoxContainer/MarginContainer/Label.text = title
	$HBoxContainer/MarginContainer2/SettingsButton.visible = show_settings

func _on_close_button_pressed():
	close_button_pressed.emit()

func _on_settings_button_pressed():
	settings_button_pressed.emit()
