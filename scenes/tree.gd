class_name FruitTree
extends Area2D
const MAX_HP = 3
const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']

var hp_related_timestamp = null

var hp = MAX_HP
var is_intact = true
var type : String
var HarvestedFruit = preload("res://scenes/fruit.tscn")
var display_type : String

func _ready():
	type = TYPES[Dice.roll_dn(5) - 1]
	display_type = type
	Events.tick.connect(_handle_event_tick)
	$FullTree.play("%s-init" % display_type)

func get_chopped():
#	print('tree is getting chopped')
	hp -= 1
	if display_type != 'none':
		z_index = 0
		$FullTree.play("%s-shed" % display_type)
		
	elif is_intact:
		$FullTree.frame = 0
		$FullTree.play("none-wind")
#			collision_layer = 0
	else:
		queue_free()

func _on_button_pressed():
#	print('tree button pressed')
	Events.select_fruit_tree.emit(self)



func _handle_event_tick(timestamp: int):
	if not hp_related_timestamp:
		return
	if hp_related_timestamp + Constants.SETTINGS_TREE_HEAL_DURATION > timestamp:
		return
	if hp == MAX_HP:
		hp_related_timestamp = null
		display_type = type
		$FullTree.animation = "%s-wind" % display_type
		$FullTree.frame = 5
		return
	hp = hp + 1
	hp_related_timestamp = int(Time.get_unix_time_from_system())


func _on_full_tree_animation_finished():
	if $FullTree.animation == "%s-shed" % display_type:

		for i in range(3):
			var f = HarvestedFruit.instantiate()
			f.set_fruit_data(type, i)
			
			add_child(f)

		display_type = 'none'
		$FullTree.animation = "%s-wind" % display_type
		$FullTree.frame = 5
		z_index = 10
		hp_related_timestamp = int(Time.get_unix_time_from_system())

	elif $FullTree.animation == "none-wind":
		if hp == 0:
			is_intact = false
			$FullTree.visible = false
			$FullTree/StaticBody2D.collision_layer = 0
		else:
			hp_related_timestamp = int(Time.get_unix_time_from_system())
