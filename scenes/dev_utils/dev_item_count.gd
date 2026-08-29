class_name DevItemCount
extends MarginContainer

var type

var value

func populate():
	if type == 'vegetable':
		if value == 'Carrot':
			breakpoint
		var v = Constants.VEGETABLE_TYPE[value]
		var t = Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[v]
		$HBoxContainer/TextureRect.texture = t
		$HBoxContainer/Label.text = "%s (%s)" % [value, State.stats_and_inventory.inventory.vegetable[v]]

func _on_decrease_pressed() -> void:
	pass # Replace with function body.


func _on_increase_pressed() -> void:
	pass # Replace with function body.
