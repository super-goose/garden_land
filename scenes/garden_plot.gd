class_name GardenPlot
extends Area2D

#enum TYPE {
#	_corn, _still_corn, carrot, cauliflower, tomato,
#	eggplant, _blue_flower, lettuce, wheat, pumpkin,
#	parsnip, _rose, beet, _star_fruit, cucumber
#}
@export var type : Constants.TYPE = Constants.TYPE.None #TYPE

var action_types: Array[Constants.ACTIONS] = [Constants.ACTIONS.Hoe, Constants.ACTIONS.Water, Constants.ACTIONS.Sow]

enum STAGE { empty, sprout, growing, showing, ready, corn }
@export var stage : STAGE = STAGE.empty

@export var debug_name : String = ''

# Called when the node enters the scene tree for the first time.
func _ready():
#	print(int(type))
#	print(int(stage))
	$FarmingPlants.visible = stage != STAGE.empty
	$FarmingPlants.frame = int(stage)

func set_stage(s: STAGE):
	stage = s
	$FarmingPlants.visible = stage != STAGE.empty
	$FarmingPlants.frame = int(stage) - 1

func increase_stage():
#	print('increasing stage for %s' % debug_name)
	if not type or stage == STAGE.ready:
		return
	var new_stage = {
		STAGE.empty: STAGE.sprout,
		STAGE.sprout: STAGE.growing,
		STAGE.growing: STAGE.showing,
		STAGE.showing: STAGE.ready,
	}[stage]
	set_stage(new_stage)

func set_type(t: Constants.TYPE):
	type = t
	if type != Constants.TYPE.None:
		var textures = {
			Constants.TYPE.Corn: load("res://modified-assets/plant-grow-sprites/corn.png"),
			Constants.TYPE.Carrot: load("res://modified-assets/plant-grow-sprites/carrot.png"),
			Constants.TYPE.Cauliflower: load("res://modified-assets/plant-grow-sprites/cauliflower.png"),
			Constants.TYPE.Tomato: load("res://modified-assets/plant-grow-sprites/tomato.png"),
			Constants.TYPE.Eggplant: load("res://modified-assets/plant-grow-sprites/eggplant.png"),
			Constants.TYPE.BlueFlower: load("res://modified-assets/plant-grow-sprites/flower.png"),
			Constants.TYPE.Lettuce: load("res://modified-assets/plant-grow-sprites/lettuce.png"),
			Constants.TYPE.Wheat: load("res://modified-assets/plant-grow-sprites/wheat.png"),
			Constants.TYPE.Pumpkin: load("res://modified-assets/plant-grow-sprites/pumpkin.png"),
			Constants.TYPE.Parsnip: load("res://modified-assets/plant-grow-sprites/parsnip.png"),
			Constants.TYPE.Rose: load("res://modified-assets/plant-grow-sprites/rose.png"),
			Constants.TYPE.Beet: load("res://modified-assets/plant-grow-sprites/beet.png"),
			Constants.TYPE.StarFruit: load("res://modified-assets/plant-grow-sprites/star-fruit.png"),
			Constants.TYPE.Cucumber: load("res://modified-assets/plant-grow-sprites/cucumber.png"),
		}
		$FarmingPlants.texture = textures[type]
		$FarmingPlants.hframes = 5 if type == Constants.TYPE.Corn else 4
		$FarmingPlants.vframes = 1
		$FarmingPlants.frame = 0
		

"""
plants:
0 - corn
1 - still corn
2 - carrot
3 - cauliflower
4 - tomato
5 - eggplant
6 - blue flower
7 - lettuce
8 - wheat
9 - pumpkin
10 - parsnip
11 - rose maybe
12 - beet
13 - star fruit??
14 - cucumber

stages:
0 - sprout
1 - growing
2 - showing
3 - ready
4 - corn (don't use)
"""



func _on_button_pressed():
	Events.select_garden_plot.emit(self)
