class_name FruitTree
extends Area2D

var hp = 10
var is_intact = true

func get_chopped():
	print('tree is getting chopped')
	if not is_intact:
		return
	hp -= 4
	$FullTree.play("wind")
	if hp < 0:
		is_intact = false
		$FullTree.visible = false
		$FullTree/StaticBody2D.collision_layer = 0
		collision_layer = 0
