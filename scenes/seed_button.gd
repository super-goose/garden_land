class_name SeedButton
extends TextureButton

var type: Constants.TYPE

func _ready():
	pass

func set_button_type(_type: Constants.TYPE):
	type = _type
	var button_image = {
		Constants.TYPE.Corn: load("res://modified-assets/tools/farm-plant-seed-corn.png"),
		Constants.TYPE.Carrot: load("res://modified-assets/tools/farm-plant-seed-carrot.png"),
		Constants.TYPE.Cauliflower: load("res://modified-assets/tools/farm-plant-seed-cauliflower.png"),
		Constants.TYPE.Tomato: load("res://modified-assets/tools/farm-plant-seed-tomato.png"),
		Constants.TYPE.Eggplant: load("res://modified-assets/tools/farm-plant-seed-eggplant.png"),
		Constants.TYPE.BlueFlower: load("res://modified-assets/tools/farm-plant-seed-blueflower.png"),
		Constants.TYPE.Lettuce: load("res://modified-assets/tools/farm-plant-seed-lettuce.png"),
		Constants.TYPE.Wheat: load("res://modified-assets/tools/farm-plant-seed-wheat.png"),
		Constants.TYPE.Pumpkin: load("res://modified-assets/tools/farm-plant-seed-pumpkin.png"),
		Constants.TYPE.Parsnip: load("res://modified-assets/tools/farm-plant-seed-parsnip.png"),
		Constants.TYPE.Rose: load("res://modified-assets/tools/farm-plant-seed-flower.png"),
		Constants.TYPE.Beet: load("res://modified-assets/tools/farm-plant-seed-beet.png"),
		Constants.TYPE.StarFruit: load("res://modified-assets/tools/farm-plant-seed-starfruit.png"),
		Constants.TYPE.Cucumber: load("res://modified-assets/tools/farm-plant-seed-cucumber.png"),
	}
	texture_normal = button_image[_type]
	

func _on_pressed():
	Events.select_seed_type.emit(type)
	Events.hide_seed_options.emit()
