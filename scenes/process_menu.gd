extends MarginContainer

@onready var button_container_container = $MarginContainer/VBoxContainer/ColorRect
@onready var button_container = $MarginContainer/VBoxContainer/ColorRect/VBoxContainer

var ProcessingButton = load("res://scenes/menu_process_button.tscn")

func open():
	visible = true
	clear_items()

func close():
	visible = false

func add_item(item: Dictionary):
	var b = ProcessingButton.instantiate()
	b.set_words(item['words'])
	b.set_functionality(item['functionality'])
	button_container.add_child(b)
	button_container_container.custom_minimum_size.y += 85

func clear_items():
	for n in button_container.get_children():
		button_container.remove_child(n)
		n.queue_free()
	button_container_container.custom_minimum_size.y = 0

func _on_button_pressed():
	close()
