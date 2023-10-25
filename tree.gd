class_name FruitTree
extends Area2D

var hp = 2
var is_intact = true

func get_chopped():
	print('tree is getting chopped')
	hp -= 1
	if is_intact:
		$FullTree.play("wind")
		if hp < 0:
			is_intact = false
			$FullTree.visible = false
			$FullTree/StaticBody2D.collision_layer = 0
#			collision_layer = 0
	else:
		if hp == -2:
			queue_free()
