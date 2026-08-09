@tool
@icon("res://modified-assets/ui/action-button-letter.png")
extends Control

@export var current_quest: Quest : set = _set_current_quest

@onready var menu_header = $MarginContainer/VBoxContainer/MenuHeader
@onready var letter_content = $MarginContainer/VBoxContainer/ContentContainer/MarginContainer/LetterContent/RichTextLabel

func _set_current_quest(q: Quest):
	current_quest = q
	fill_out_letter_content()

func fill_out_letter_content():
	if not is_node_ready():
		await ready

	menu_header.title = current_quest.name
	letter_content.text = current_quest.blurb

func _ready():
	#menu_header.close_button_pressed.connect(_on_close_button_pressed)
	#menu_header.settings_button_pressed.connect(_on_settings_button_pressed)
	if not Engine.is_editor_hint():
		Events.open_letter.connect(open_letter)

	if current_quest:
		fill_out_letter_content()

func open_letter(quest: Quest):
	current_quest = quest
	print(quest.name)
	visible = true

func _on_close_button_pressed():
	visible = false
	Events.confirmation_granted.emit()
