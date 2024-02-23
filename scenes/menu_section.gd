extends MarginContainer

@export var title: String = 'whatevs'
@onready var grid_container = $VBoxContainer/GridContainer
@onready var section_label = $VBoxContainer/LabelContainer/Label

func _ready():
	section_label.text = title

func set_items(items: Array):
	clear_items()
	for i in items:
		grid_container.add_child(i)

func clear_items():
	for n in grid_container.get_children():
		grid_container.remove_child(n)
		n.queue_free()
