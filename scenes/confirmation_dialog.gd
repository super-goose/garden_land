extends "res://scenes/process_menu.gd"

var ConfirmationPrompt = load("res://scenes/confirmation_prompt.tscn")

func _ready():
	Events.open_confirmation_menu.connect(_handle_event_open_confirmation_menu)

'''override'''
func close():
	Events.confirmation_granted.emit(false)
	visible = false

func _handle_event_open_confirmation_menu(prompt: String):
	open()
	var cp = ConfirmationPrompt.instantiate()
	cp.set_text(prompt)
	add_to_button_container(cp)

	add_item({
		'words': 'yes',
		'functionality': confirm
	})

	add_item({
		'words': 'no',
		'functionality': close
	})

func confirm():
	Events.confirmation_granted.emit(true)
	visible = false
