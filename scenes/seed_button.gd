class_name SeedButton
extends TextureButton

var type: Constants.PLANT_TYPE

func _ready():
	pass

func set_button_type(_type: Constants.PLANT_TYPE):
	type = _type
	var button_image = {
		Constants.PLANT_TYPE.Corn: load("res://modified-assets/farm-plants/farm-plant-seed-corn.png"),
		Constants.PLANT_TYPE.Carrot: load("res://modified-assets/farm-plants/farm-plant-seed-carrot.png"),
		Constants.PLANT_TYPE.Cauliflower: load("res://modified-assets/farm-plants/farm-plant-seed-cauliflower.png"),
		Constants.PLANT_TYPE.Tomato: load("res://modified-assets/farm-plants/farm-plant-seed-tomato.png"),
		Constants.PLANT_TYPE.Eggplant: load("res://modified-assets/farm-plants/farm-plant-seed-eggplant.png"),
		Constants.PLANT_TYPE.BlueFlower: load("res://modified-assets/farm-plants/farm-plant-seed-blueflower.png"),
		Constants.PLANT_TYPE.Lettuce: load("res://modified-assets/farm-plants/farm-plant-seed-lettuce.png"),
		Constants.PLANT_TYPE.Wheat: load("res://modified-assets/farm-plants/farm-plant-seed-wheat.png"),
		Constants.PLANT_TYPE.Pumpkin: load("res://modified-assets/farm-plants/farm-plant-seed-pumpkin.png"),
		Constants.PLANT_TYPE.Parsnip: load("res://modified-assets/farm-plants/farm-plant-seed-parsnip.png"),
		Constants.PLANT_TYPE.Rose: load("res://modified-assets/farm-plants/farm-plant-seed-flower.png"),
		Constants.PLANT_TYPE.Beet: load("res://modified-assets/farm-plants/farm-plant-seed-beet.png"),
		Constants.PLANT_TYPE.StarFruit: load("res://modified-assets/farm-plants/farm-plant-seed-starfruit.png"),
		Constants.PLANT_TYPE.Cucumber: load("res://modified-assets/farm-plants/farm-plant-seed-cucumber.png"),
	}
	texture_normal = button_image[_type]
	

func _on_pressed():
	Events.select_seed_type.emit(type)
	Events.hide_seed_options.emit()
