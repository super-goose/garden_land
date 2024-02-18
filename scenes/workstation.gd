class_name Workstation
extends Node2D

func _on_button_pressed():
	Events.select_workstation.emit(self)
