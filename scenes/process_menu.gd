extends MarginContainer

@onready var button_container = $MarginContainer/VBoxContainer

var ProcessingButton = load("res://scenes/menu_process_button.tscn")

func open():
	visible = true
	clear_items()

func close():
	visible = false

func add_item(item: Array):
	var b = ProcessingButton.instatiate()
	b.set_words(item[0])
	b.set_functionality(item[1])
	button_container.add_child(b)

func clear_items():
	for n in button_container.get_children():
		button_container.remove_child(n)
		n.queue_free()

