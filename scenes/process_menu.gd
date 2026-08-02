extends MarginContainer

@onready var button_container_container = $MarginContainer/VBoxContainer/ColorRect
@onready var button_container = $MarginContainer/VBoxContainer/ColorRect/VBoxContainer

var ProcessingButtonScene = load("res://scenes/menu_process_button.tscn")
var ProcessingSliderScene = load("res://scenes/menu_process_slider.tscn")

func open():
	visible = true
	clear_items()

func close():
	visible = false

func add_item(item: Dictionary):
	if item['type'] == 'button':
		var b = ProcessingButtonScene.instantiate()
		b.set_words(item['words'])
		b.set_functionality(item['functionality'])
		add_to_button_container(b)
	elif item['type'] == 'slider':
		var s = ProcessingSliderScene.instantiate()
		s.set_functionality(item['functionality'], item['cancel'])
		s.set_max_value(item['max_value'])
		add_to_slider_container(s)

func add_to_button_container(item):
	button_container.add_child(item)
	button_container_container.custom_minimum_size.y += 85

func add_to_slider_container(item):
	button_container.add_child(item)
	button_container_container.custom_minimum_size.y += 138

func clear_items():
	for n in button_container.get_children():
		button_container.remove_child(n)
		n.queue_free()
	button_container_container.custom_minimum_size.y = 0

func _on_button_pressed():
	close()
