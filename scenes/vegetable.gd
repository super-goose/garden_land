class_name Vegetable
extends "res://scenes/bases/collectible.gd"

var direction: float
var type: Constants.VEGETABLE_TYPE

func _ready():
	do_animation(
		func vegetable_tween_callback():
			Events.harvest_plant.emit(type)
			Events.vegetable_was_harvested.emit()
			queue_free()
	)

#func _init():
#	pass

func set_vegetable_data(VEGETABLE_TYPE: Constants.VEGETABLE_TYPE, index: int):
	type = VEGETABLE_TYPE
	frame = [
		Constants.VEGETABLE_TYPE.Beet,
		Constants.VEGETABLE_TYPE.Carrot,
		Constants.VEGETABLE_TYPE.Cauliflower,
		Constants.VEGETABLE_TYPE.Corn,
		Constants.VEGETABLE_TYPE.Cucumber,
		Constants.VEGETABLE_TYPE.Eggplant,
		Constants.VEGETABLE_TYPE.BlueFlower,
		Constants.VEGETABLE_TYPE.Lettuce,
		Constants.VEGETABLE_TYPE.Parsnip,
		Constants.VEGETABLE_TYPE.Pumpkin,
		Constants.VEGETABLE_TYPE.Rose,
		Constants.VEGETABLE_TYPE.StarFruit,
		Constants.VEGETABLE_TYPE.Tomato,
		Constants.VEGETABLE_TYPE.Wheat,
	].find(type)

	position = [
		Vector2(11, -22),
		Vector2(-11, -22),
		Vector2(11, 22),
		Vector2(-11, 22),
		Vector2(22, -11),
		Vector2(-22, -11),
		Vector2(22, 11),
		Vector2(-22, 11),
	][index]
