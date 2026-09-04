class_name DevItemCount
extends MarginContainer

var type

var value

func populate():
	if type == 'vegetable':
		var v = Constants.VEGETABLE_TYPE[value]
		var t = Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[v]
		$HBoxContainer/TextureRect.texture = t
		$HBoxContainer/Label.text = "%s (%s)" % [value, State.stats_and_inventory.inventory.vegetable[v]]

	elif type == 'fruit':
		var f = Constants.FRUIT_TYPE[value]
		var t = Constants.INDIVIDUAL_FRUIT_BY_FRUIT_TYPE[f]
		$HBoxContainer/TextureRect.texture = t
		$HBoxContainer/Label.text = "%s (%s)" % [value, State.stats_and_inventory.inventory.fruit[f]]

	elif type == 'consumable':
		var c = Constants.CONSUMABLE_TYPE[value]
		var t = Constants.INDIVIDUAL_CONSUMABLE_BY_CONSUMABLE_TYPE[c]
		$HBoxContainer/TextureRect.texture = t
		$HBoxContainer/Label.text = "%s (%s)" % [value, State.stats_and_inventory.inventory.consumable[c]]

func _on_decrease_pressed() -> void:
	if type == 'vegetable':
		var v = Constants.VEGETABLE_TYPE[value]
		State.stats_and_inventory.inventory.vegetable[v] -= 1
	if type == 'fruit':
		var f = Constants.FRUIT_TYPE[value]
		State.stats_and_inventory.inventory.fruit[f] -= 1
	if type == 'consumable':
		var c = Constants.CONSUMABLE_TYPE[value]
		State.stats_and_inventory.inventory.consumable[c] -= 1
	Events.refresh_stats_and_inventory.emit()


func _on_increase_pressed() -> void:
	if type == 'vegetable':
		var v = Constants.VEGETABLE_TYPE[value]
		State.stats_and_inventory.inventory.vegetable[v] += 1
	if type == 'fruit':
		var f = Constants.FRUIT_TYPE[value]
		State.stats_and_inventory.inventory.fruit[f] += 1
	if type == 'consumable':
		var c = Constants.CONSUMABLE_TYPE[value]
		State.stats_and_inventory.inventory.consumable[c] += 1

	Events.refresh_stats_and_inventory.emit()
