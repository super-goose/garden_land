extends CanvasLayer

@onready var actions_container = $Actions/ColorRect/ColorRect/HBoxContainer
@onready var seeds_container = $Seeds/ColorRect/HBoxContainer

var seeds_duration = .3
var pos_y_seeds_in = 269 # get this dynamically
var pos_y_seeds_out = 269 + 51 + 200 # get this dynamically (200 is padding for taller screens)

@onready var SeedButton = load("res://scenes/seed_button.tscn")
@onready var ActionsMenuButton = load("res://scenes/actions_menu_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	print('connecting hud stuff')
	Events.set_actions.connect(_handle_set_actions)
	Events.display_seed_options.connect(_handle_display_seed_options)
	Events.hide_seed_options.connect(_handle_hide_seed_options)
	__populate_actions()
	__populate_seed_options()
	_handle_hide_seed_options()

func _handle_set_actions(actions: Array):
	for child in actions_container.get_children():
		child.visible = actions.has(child.action)

func _handle_display_seed_options(seeds: Array):
	for child in seeds_container.get_children():
		child.visible = seeds.has(child.type)
	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_in)
	$Seeds.visible = true
	t.tween_property($Seeds, 'position', new_position, seeds_duration)

func _handle_hide_seed_options():
	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_out)
	await t.tween_property($Seeds, 'position', new_position, seeds_duration)
	$Seeds.visible = false

func __populate_seed_options():
	for seed_type in Constants.PLANT_TYPE:
		if seed_type == 'None':
			continue
#		print(str(seed_type))
		var s = SeedButton.instantiate()
		s.set_button_type(Constants.PLANT_TYPE[seed_type])
		seeds_container.add_child(s)

func __populate_actions():
	for action in Constants.ACTIONS:
		var a = ActionsMenuButton.instantiate()
		a.set_button_type(Constants.ACTIONS[action])
		actions_container.add_child(a)
