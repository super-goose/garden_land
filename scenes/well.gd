class_name WaterWell
extends Area2D

func _on_button_pressed():
	Events.select_water_well.emit(self)
