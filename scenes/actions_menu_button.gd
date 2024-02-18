class_name ActionsMenuButton
extends TextureButton

@export var action: Constants.ACTIONS
var action_image

func _ready():
	action_image = {
		Constants.ACTIONS.RefillWater: load("res://modified-assets/ui/action-button-water-well.png"),
		Constants.ACTIONS.WorkAtStation: load("res://modified-assets/ui/action-button-workstation.png"),
		Constants.ACTIONS.CheckMail: load("res://modified-assets/ui/action-button-letter.png"),
		Constants.ACTIONS.Menu: load("res://modified-assets/ui/menu_button.png"),
		Constants.ACTIONS.Hoe: load("res://modified-assets/tools/tools-hoe.png"),
		Constants.ACTIONS.Water: load("res://modified-assets/tools/tools-water-can.png"),
		Constants.ACTIONS.Chop: load("res://modified-assets/tools/tools-axe.png"),
		Constants.ACTIONS.Sow: load("res://modified-assets/farm-plants/farm-plant-seed-blank.png"),
		Constants.ACTIONS.Harvest_Corn: load("res://modified-assets/farm-plants/farm-plant-corn.png"),
		Constants.ACTIONS.Harvest_Carrot: load("res://modified-assets/farm-plants/farm-plant-carrot.png"),
		Constants.ACTIONS.Harvest_Cauliflower: load("res://modified-assets/farm-plants/farm-plant-cauliflower.png"),
		Constants.ACTIONS.Harvest_Tomato: load("res://modified-assets/farm-plants/farm-plant-tomato.png"),
		Constants.ACTIONS.Harvest_Eggplant: load("res://modified-assets/farm-plants/farm-plant-eggplant.png"),
		Constants.ACTIONS.Harvest_BlueFlower: load("res://modified-assets/farm-plants/farm-plant-blueflower.png"),
		Constants.ACTIONS.Harvest_Lettuce: load("res://modified-assets/farm-plants/farm-plant-lettuce.png"),
		Constants.ACTIONS.Harvest_Wheat: load("res://modified-assets/farm-plants/farm-plant-wheat.png"),
		Constants.ACTIONS.Harvest_Pumpkin: load("res://modified-assets/farm-plants/farm-plant-pumpkin.png"),
		Constants.ACTIONS.Harvest_Parsnip: load("res://modified-assets/farm-plants/farm-plant-parsnip.png"),
		Constants.ACTIONS.Harvest_Rose: load("res://modified-assets/farm-plants/farm-plant-flower.png"),
		Constants.ACTIONS.Harvest_Beet: load("res://modified-assets/farm-plants/farm-plant-beet.png"),
		Constants.ACTIONS.Harvest_StarFruit: load("res://modified-assets/farm-plants/farm-plant-starfruit.png"),
		Constants.ACTIONS.Harvest_Cucumber: load("res://modified-assets/farm-plants/farm-plant-cucumber.png"),
	}
	$TextureRect.texture = action_image[action]

func set_button_type(action_type: Constants.ACTIONS):
	action = action_type

func _on_pressed():
	Events.perform_action.emit(action)
