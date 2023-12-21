class_name ActionsMenu
extends Control

const OFFSET = Vector2(-3, -2)
var distance = 40

var ActionButton = load('res://scenes/actions_menu_button.tscn')

func add_actions(actions: Array[Constants.ACTIONS]):
	for action in actions:
		var b = ActionButton.instantiate()
		b.set_action(action)
		b.visible = false
		b.position = OFFSET
		add_child(b)

func display_actions(direction = 'up'):
	var r = {
		'up': 0,
		'left': PI / 2,
		'down': PI,
		'right': -PI / 2
	}[direction]
	var children = get_children()
	var size = children.size()
	for i in range(size):
		var angle = (PI * i / 4) - ((PI / 4) * size / 2) + r
		var new_position = (Vector2.UP.rotated(angle) * distance) + OFFSET
		var t = get_tree().create_tween()
		var duration = .25
		children[i].visible = true
		t.tween_property(children[i], 'position', new_position, duration)
		
		
#	ActionsMenuButton
	var angles = []
#	print('add calculations here to display actions menu')
	
func hide_actions():
	pass
