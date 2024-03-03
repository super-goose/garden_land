class_name SeedButton
extends Control

var type: Constants.VEGETABLE_TYPE

func set_button_type(_type: Constants.VEGETABLE_TYPE):
	type = _type
	var button_image = {
		Constants.VEGETABLE_TYPE.Corn: load("res://modified-assets/farm-plants/farm-plant-seed-corn.png"),
		Constants.VEGETABLE_TYPE.Carrot: load("res://modified-assets/farm-plants/farm-plant-seed-carrot.png"),
		Constants.VEGETABLE_TYPE.Cauliflower: load("res://modified-assets/farm-plants/farm-plant-seed-cauliflower.png"),
		Constants.VEGETABLE_TYPE.Tomato: load("res://modified-assets/farm-plants/farm-plant-seed-tomato.png"),
		Constants.VEGETABLE_TYPE.Eggplant: load("res://modified-assets/farm-plants/farm-plant-seed-eggplant.png"),
		Constants.VEGETABLE_TYPE.BlueFlower: load("res://modified-assets/farm-plants/farm-plant-seed-blueflower.png"),
		Constants.VEGETABLE_TYPE.Lettuce: load("res://modified-assets/farm-plants/farm-plant-seed-lettuce.png"),
		Constants.VEGETABLE_TYPE.Wheat: load("res://modified-assets/farm-plants/farm-plant-seed-wheat.png"),
		Constants.VEGETABLE_TYPE.Pumpkin: load("res://modified-assets/farm-plants/farm-plant-seed-pumpkin.png"),
		Constants.VEGETABLE_TYPE.Parsnip: load("res://modified-assets/farm-plants/farm-plant-seed-parsnip.png"),
		Constants.VEGETABLE_TYPE.Rose: load("res://modified-assets/farm-plants/farm-plant-seed-flower.png"),
		Constants.VEGETABLE_TYPE.Beet: load("res://modified-assets/farm-plants/farm-plant-seed-beet.png"),
		Constants.VEGETABLE_TYPE.StarFruit: load("res://modified-assets/farm-plants/farm-plant-seed-starfruit.png"),
		Constants.VEGETABLE_TYPE.Cucumber: load("res://modified-assets/farm-plants/farm-plant-seed-cucumber.png"),
	}
	$TextureRect.texture = button_image[_type]

func _on_button_pressed():
	Events.select_seed_type.emit(type)
	Events.hide_seed_options.emit()

func set_amount(amount: int):
	$TextureRect/Label.visible = amount > 0
	$TextureRect/Label.text = "%s" % amount
