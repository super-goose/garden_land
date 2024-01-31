class_name FruitTree
extends Area2D

const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']
var hp = 2
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
		var fruit_type = {
			'apple': Constants.FRUIT_TYPE.Apple,
			'orange': Constants.FRUIT_TYPE.Orange,
			'pear': Constants.FRUIT_TYPE.Pear,
			'peach': Constants.FRUIT_TYPE.Peach,
		}[display_type]
		display_type = 'none'

		var f1 = Fruit.instantiate()
		f1.set_fruit_data(fruit_type, PI / 3)
		add_child(f1)

		var f2 = Fruit.instantiate()
		f2.set_fruit_data(fruit_type, 2 * PI / 3)
		add_child(f2)

		var f3 = Fruit.instantiate()
		f3.set_fruit_data(fruit_type, 4 * PI / 3)
		add_child(f3)
		
	if is_intact:
		$FullTree.play("%s-wind" % display_type)
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
