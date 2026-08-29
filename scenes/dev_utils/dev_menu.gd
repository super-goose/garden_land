extends MarginContainer

func _on_copy_button_pressed() -> void:
	var json_string = JSON.stringify(State.state_to_dict(), '  ')
	DisplayServer.clipboard_set(json_string)

func _on_paste_button_pressed() -> void:
	var json = JSON.new()
	var error = json.parse(DisplayServer.clipboard_get())

	if error == OK:
		var data = json.get_data()
		State.dict_to_state(data)
	else:
		print("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
