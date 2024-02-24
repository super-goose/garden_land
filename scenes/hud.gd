extends CanvasLayer

@onready var actions_container = $Actions/ColorRect/HBoxContainer
@onready var seeds_container = $Seeds/ColorRect/HBoxContainer

var seeds_duration = .3
var pos_y_seeds_in = 544 # get this dynamically
var pos_y_seeds_out = 544 + 102 + 200 # get this dynamically (200 is padding for taller screens)
var hour_frame = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

@onready var SeedButton = load("res://scenes/seed_button.tscn")
@onready var ActionsMenuButton = load("res://scenes/actions_menu_button.tscn")

func _ready():
	print('connecting hud stuff')
	Events.set_actions.connect(_handle_set_actions)
	Events.display_seed_options.connect(_handle_display_seed_options)
	Events.hide_seed_options.connect(_handle_hide_seed_options)
	Events.set_water_level.connect(set_water_level)
	Events.set_water_level_max.connect(set_water_level_max)
	Events.increase_hour.connect(increase_hour)

	__populate_actions()
	__populate_seed_options()
	_handle_hide_seed_options()

func increase_hour(hour: int, _am_pm):
	var x = 16 * hour_frame.find(hour)
	$Clock/TextureRect.texture.region = Rect2(x, 0, 16, 16)

func set_water_level(value: int):
	$WaterLevel/TextureProgressBar.value = value

func set_water_level_max(value: int):
	$WaterLevel/TextureProgressBar.max_value = value

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
	for seed_type in Constants.VEGETABLE_TYPE:
		if seed_type == 'None':
			continue
#		print(str(seed_type))
		var s = SeedButton.instantiate()
		s.set_button_type(Constants.VEGETABLE_TYPE[seed_type])
		seeds_container.add_child(s)

func __populate_actions():
	actions_container.get_children()
	for action in Constants.ACTIONS:
		var a = ActionsMenuButton.instantiate()
		a.set_button_type(Constants.ACTIONS[action])
		actions_container.add_child(a)
