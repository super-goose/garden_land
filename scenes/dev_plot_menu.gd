extends "res://scenes/process_menu.gd"

func _ready():
	Events.open_dev_plot_menu.connect(open)
	Events.add_to_dev_plot_menu.connect(add_to_dev_plot_menu)
	Events.close_dev_plot_menu.connect(close)


func add_to_dev_plot_menu(items):
	for item in items:
		add_item(item)
