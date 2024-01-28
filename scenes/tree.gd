class_name FruitTree
extends Area2D

const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']
var hp = 2
var is_intact = true
var type : String

#var action_types : Array[Constants.ACTIONS] = [Constants.ACTIONS.Chop]

func _ready():
	type = TYPES[Dice.roll_dn(5) - 1]
	$FullTree.play("%s-init" % type)

func get_chopped():
#	print('tree is getting chopped')
	hp -= 1
	if is_intact:
		$FullTree.play("%s-wind" % type)
		if hp < 0:
			is_intact = false
			$FullTree.visible = false
			$FullTree/StaticBody2D.collision_layer = 0
#			collision_layer = 0
	else:
		if hp == -2:
			queue_free()

func _on_button_pressed():
#	print('tree button pressed')
	Events.select_fruit_tree.emit(self)
