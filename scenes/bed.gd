class_name Bed
extends Area2D

func _on_button_pressed():
	Events.select_bed.emit(self)
