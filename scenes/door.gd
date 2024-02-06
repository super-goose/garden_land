extends Node2D

func _on_area_2d_area_entered(area):
	$AnimatedSprite2D.play('open')

func _on_area_2d_area_exited(area):
	$AnimatedSprite2D.play('close')
