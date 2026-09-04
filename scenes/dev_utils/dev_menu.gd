extends MarginContainer

func _ready():
	refresh()

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

func refresh():
	for child in $VBoxContainer.get_children():
		if child is not DevItemCount:
			continue
		$VBoxContainer.remove_child(child)
	
	var DevItemCountScene = preload("res://scenes/dev_utils/dev_item_count.tscn")
	for veg in Constants.VEGETABLE_TYPE:
		if veg == 'None':
			continue
		var dic = DevItemCountScene.instantiate()

		dic.type = 'vegetable'
		dic.value = veg

		$VBoxContainer.add_child(dic)
		dic.populate()

	for fruit in Constants.FRUIT_TYPE:
		if fruit == 'None':
			continue
		var dic = DevItemCountScene.instantiate()

		dic.type = 'fruit'
		dic.value = fruit

		$VBoxContainer.add_child(dic)
		dic.populate()

	for cons in Constants.CONSUMABLE_TYPE:
		if cons == 'None':
			continue
		var dic = DevItemCountScene.instantiate()

		dic.type = 'consumable'
		dic.value = cons

		$VBoxContainer.add_child(dic)
		dic.populate()
