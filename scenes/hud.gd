extends CanvasLayer

@onready var actions_container = $Actions/ColorRect/ColorRect/HBoxContainer
@onready var seeds_container = $Seeds/ColorRect/HBoxContainer

var seeds_duration = .3
var pos_y_seeds_in = 269 # get this dynamically
var pos_y_seeds_out = 269 + 51 # get this dynamically

@onready var SeedButton = load("res://scenes/seed_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print('connecting hud stuff')
	Events.set_actions.connect(_handle_set_actions)
	Events.display_seed_options.connect(_handle_display_seed_options)
	Events.hide_seed_options.connect(_handle_hide_seed_options)
	__populate_seed_options()
	_handle_hide_seed_options()


func _handle_set_actions(actions: Array):
	print('display the correct actions')
	for child in actions_container.get_children():
		child.visible = actions.has(child.action)

func _handle_display_seed_options(seeds: Array):
	for child in seeds_container.get_children():
		child.visible = seeds.has(child.type)

	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_in)
	t.tween_property($Seeds, 'position', new_position, seeds_duration)

func _handle_hide_seed_options():
	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_out)
	t.tween_property($Seeds, 'position', new_position, seeds_duration)

func __populate_seed_options():
	for seed_type in Constants.TYPE:
		if seed_type == 'None':
			continue
#		print(str(seed_type))
		var s = SeedButton.instantiate()
		s.set_button_type(Constants.TYPE[seed_type])
		seeds_container.add_child(s)
