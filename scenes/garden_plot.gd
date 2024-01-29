class_name GardenPlot
extends Area2D

@export var type : Constants.PLANT_TYPE = Constants.PLANT_TYPE.None #TYPE

enum STAGE { empty, sprout, growing, showing, ready, corn }
@export var stage : STAGE = STAGE.empty

func _ready():
	$FarmingPlants.visible = stage != STAGE.empty
	$FarmingPlants.frame = 0

func set_stage(s: STAGE):
	stage = s
	$FarmingPlants.visible = stage != STAGE.empty
	var new_frame = {
		STAGE.empty: -1,
		STAGE.sprout: 0,
		STAGE.growing: 1,
		STAGE.showing: 2,
		STAGE.corn: 3,
		STAGE.ready: 4 if type == Constants.PLANT_TYPE.Corn else 3,
	}[s]
	$FarmingPlants.frame = new_frame

func trigger_increase_stage():
	if $StageTimer.is_stopped():
		$StageTimer.start()

func _on_stage_timer_timeout():
	increase_stage()

func increase_stage():
	if type == Constants.PLANT_TYPE.None or stage == STAGE.ready:
		return

	var new_stage = {
		STAGE.empty: STAGE.sprout,
		STAGE.sprout: STAGE.growing,
		STAGE.growing: STAGE.showing,
		STAGE.showing: STAGE.corn if type == Constants.PLANT_TYPE.Corn else STAGE.ready,
		STAGE.corn: STAGE.ready,
	}[stage]
	set_stage(new_stage)

func set_type(t: Constants.PLANT_TYPE):
	type = t
	if type == Constants.PLANT_TYPE.None:
		return
	var textures = {
		Constants.PLANT_TYPE.Corn: load("res://modified-assets/plant-grow-sprites/corn.png"),
		Constants.PLANT_TYPE.Carrot: load("res://modified-assets/plant-grow-sprites/carrot.png"),
		Constants.PLANT_TYPE.Cauliflower: load("res://modified-assets/plant-grow-sprites/cauliflower.png"),
		Constants.PLANT_TYPE.Tomato: load("res://modified-assets/plant-grow-sprites/tomato.png"),
		Constants.PLANT_TYPE.Eggplant: load("res://modified-assets/plant-grow-sprites/eggplant.png"),
		Constants.PLANT_TYPE.BlueFlower: load("res://modified-assets/plant-grow-sprites/flower.png"),
		Constants.PLANT_TYPE.Lettuce: load("res://modified-assets/plant-grow-sprites/lettuce.png"),
		Constants.PLANT_TYPE.Wheat: load("res://modified-assets/plant-grow-sprites/wheat.png"),
		Constants.PLANT_TYPE.Pumpkin: load("res://modified-assets/plant-grow-sprites/pumpkin.png"),
		Constants.PLANT_TYPE.Parsnip: load("res://modified-assets/plant-grow-sprites/parsnip.png"),
		Constants.PLANT_TYPE.Rose: load("res://modified-assets/plant-grow-sprites/rose.png"),
		Constants.PLANT_TYPE.Beet: load("res://modified-assets/plant-grow-sprites/beet.png"),
		Constants.PLANT_TYPE.StarFruit: load("res://modified-assets/plant-grow-sprites/star-fruit.png"),
		Constants.PLANT_TYPE.Cucumber: load("res://modified-assets/plant-grow-sprites/cucumber.png"),
	}
	$FarmingPlants.texture = textures[type]
	$FarmingPlants.hframes = 5 if type == Constants.PLANT_TYPE.Corn else 4
	$FarmingPlants.position = Vector2(0, -12 if type == Constants.PLANT_TYPE.Corn else -5)
	$FarmingPlants.vframes = 1
	$FarmingPlants.frame = 0

func _on_button_pressed():
	Events.select_garden_plot.emit(self)
