class_name FruitTree
extends Area2D

const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']

var hp = 3
var is_intact = true
var type : String
var Fruit = preload("res://scenes/fruit.tscn")
var display_type : String

func _ready():
	type = TYPES[Dice.roll_dn(5) - 1]
	display_type = type
	$FullTree.play("%s-init" % display_type)

func get_chopped():
#	print('tree is getting chopped')
	hp -= 1
	if display_type != 'none':
		z_index = 0
		$FullTree.play("%s-shed" % display_type)
		
	elif is_intact:
		var ft = $FullTree
		$FullTree.frame = 0
		$FullTree.play("none-wind")
#			collision_layer = 0
	else:
		queue_free()

func _on_button_pressed():
#	print('tree button pressed')
	Events.select_fruit_tree.emit(self)


func _on_full_tree_animation_finished():

	if $FullTree.animation == "%s-shed" % display_type:

		for i in range(3):
			var f = Fruit.instantiate()
			f.set_fruit_data(type, i)
			add_child(f)

		display_type = 'none'
		$FullTree.animation = "%s-wind" % display_type
		$FullTree.frame = 5
		z_index = 10

	elif $FullTree.animation == "none-wind":
		if hp == 0:
			is_intact = false
			$FullTree.visible = false
			$FullTree/StaticBody2D.collision_layer = 0
