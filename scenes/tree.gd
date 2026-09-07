class_name FruitTree
extends Area2D

## when the tree enters the scene, and the type has been
## defined, play the wind animation for that type
var first_time_up_in_the_club = true

var state: FruitTreeState

var coordinates : Vector2i

var HarvestedFruit = preload("res://scenes/fruit.tscn")

func _ready():
	Events.tick.connect(_handle_event_tick)
	coordinates = Common.convert_to_grid_coordinates(position)

	State.register_tree(self)

func post_state_visual_update():
	if first_time_up_in_the_club:
		if state.is_intact:
			$FullTree.play("%s-init" % state.display_type)
			first_time_up_in_the_club = false
		else:
			queue_free()

	elif state.display_type != 'none':
		z_index = 0
		$FullTree.play("%s-shed" % state.display_type)

	elif state.is_intact:
		$FullTree.frame = 0
		$FullTree.play("none-wind")

	else:
		queue_free()


func get_chopped():
	state.hp -= 1
	post_state_visual_update()
	State.update_tree(self)

func _on_button_pressed():
#	print('tree button pressed')
	Events.select_fruit_tree.emit(self)



func _handle_event_tick(timestamp: int):
	if not state.hp_related_timestamp:
		return
	if state.hp_related_timestamp + Constants.SETTINGS_TREE_HEAL_DURATION > timestamp:
		return
	if state.hp == state.MAX_HP:
		state.hp_related_timestamp = null
		state.display_type = state.type
		$FullTree.animation = "%s-wind" % state.display_type
		$FullTree.frame = 5
		return
	state.hp = state.hp + 1
	state.hp_related_timestamp = int(Time.get_unix_time_from_system())
	State.update_tree(self)


func _on_full_tree_animation_finished():
	if $FullTree.animation == "%s-shed" % state.display_type:

		for i in range(3):
			var f = HarvestedFruit.instantiate()
			f.set_fruit_data(state.type, i)
			
			add_child(f)

		state.display_type = 'none'
		$FullTree.animation = "%s-wind" % state.display_type
		$FullTree.frame = 5
		z_index = 10
		state.hp_related_timestamp = int(Time.get_unix_time_from_system())

	elif $FullTree.animation == "none-wind":
		if state.hp == 0:
			state.is_intact = false
			$FullTree.visible = false
			$FullTree/StaticBody2D.collision_layer = 0
		else:
			state.hp_related_timestamp = int(Time.get_unix_time_from_system())

	State.update_tree(self)
