@icon("res://modified-assets/ui/action-button-letter.png")
extends Control

@onready var menu_header = $MarginContainer/VBoxContainer/MenuHeader

func _ready():
	menu_header.close_button_pressed.connect(_on_close_button_pressed)
	#menu_header.settings_button_pressed.connect(_on_settings_button_pressed)
	Events.open_letter.connect(open_letter)

func open_letter(quest: Quest):
	print(quest.name)
	visible = true

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
