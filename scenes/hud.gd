extends CanvasLayer

@onready var actions_container_container = $Actions/VBoxContainer
@onready var actions_container = $Actions/VBoxContainer/MarginContainer/HBoxContainer
@onready var seeds_container = $Seeds/ColorRect/GridContainer

var seeds_duration = .3
var pos_y_seeds_in = 544 # get this dynamically
var pos_y_seeds_out = 544 + 102 + 200 # get this dynamically (200 is padding for taller screens)

@onready var SeedButtonScene = load("res://scenes/seed_button.tscn")
@onready var ActionsMenuButtonScene = load("res://scenes/actions_menu_button.tscn")

func _ready():
	print('connecting hud stuff')
	Events.set_actions.connect(_handle_set_actions)
	Events.display_seed_options.connect(_handle_display_seed_options)
	Events.hide_seed_options.connect(_handle_hide_seed_options)
	Events.set_water_level.connect(set_water_level)
	Events.set_water_level_max.connect(set_water_level_max)
	Events.set_action_tutorial.connect(_handle_set_action_tutorial)

	__populate_actions()
	__populate_seed_options()
	_handle_hide_seed_options()

func set_water_level(value: int):
	$WaterLevel/TextureProgressBar.value = value

func set_water_level_max(value: int):
	$WaterLevel/TextureProgressBar.max_value = value

func _handle_set_actions(actions: Array):
	for child in actions_container.get_children():
		child.visible = actions.has(child.action)

func _handle_display_seed_options(seeds: Dictionary):
	for child in seeds_container.get_children():
		child.visible = seeds[child.type] > 0
		child.set_amount(seeds[child.type])
	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_in)
	$Seeds.visible = true
	$Button.visible = true
	t.tween_property($Seeds, 'position', new_position, seeds_duration)

func _handle_hide_seed_options():
	var t = get_tree().create_tween()
	var new_position = Vector2(0, pos_y_seeds_out)
	await t.tween_property($Seeds, 'position', new_position, seeds_duration).finished
	$Seeds.visible = false
	$Button.visible = false

func __populate_seed_options():
	for child in seeds_container.get_children():
		seeds_container.remove_child(child)
	for seed_type in Constants.VEGETABLE_TYPE:
		if seed_type == 'None':
			continue
#		print(str(seed_type))
		var s = SeedButtonScene.instantiate()
		s.set_button_type(Constants.VEGETABLE_TYPE[seed_type])
		seeds_container.add_child(s)

func __populate_actions():
	for child in actions_container.get_children():
		actions_container.remove_child(child)

	for action in Constants.ACTIONS:
		var a = ActionsMenuButtonScene.instantiate()
		a.set_button_type(Constants.ACTIONS[action])
		actions_container.add_child(a)


func _on_button_pressed() -> void:
	_handle_hide_seed_options()

var popover_dialogue
func _handle_set_action_tutorial(action_tutorial_type: String):
	popover_dialogue = PopoverDialogue.create_and_set_text("This is the actions dialogue: %s" % action_tutorial_type)
	actions_container_container.add_child(popover_dialogue)
	actions_container_container.move_child(popover_dialogue, 0)
	print($Actions.position)

func clear_action_tutorial():
	actions_container_container.remove_child(popover_dialogue)
	popover_dialogue.queue_free()
	
