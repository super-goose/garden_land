class_name Vegetable
extends "res://scenes/bases/collectible.gd"

var direction: float
var type: Constants.PLANT_TYPE

func _ready():
	do_animation(
		func vegetable_tween_callback():
			Events.harvest_plant.emit(type)
			Events.vegetable_was_harvested.emit()
			queue_free()
	)

#func _init():
#	pass

func set_vegetable_data(plant_type: Constants.PLANT_TYPE, index: int):
	type = plant_type
	frame = [
		Constants.PLANT_TYPE.Beet,
		Constants.PLANT_TYPE.Carrot,
		Constants.PLANT_TYPE.Cauliflower,
		Constants.PLANT_TYPE.Corn,
		Constants.PLANT_TYPE.Cucumber,
		Constants.PLANT_TYPE.Eggplant,
		Constants.PLANT_TYPE.BlueFlower,
		Constants.PLANT_TYPE.Lettuce,
		Constants.PLANT_TYPE.Parsnip,
		Constants.PLANT_TYPE.Pumpkin,
		Constants.PLANT_TYPE.Rose,
		Constants.PLANT_TYPE.StarFruit,
		Constants.PLANT_TYPE.Tomato,
		Constants.PLANT_TYPE.Wheat,
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
