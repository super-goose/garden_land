class_name GardenPlot
extends Area2D

@export var type : Constants.TYPE = Constants.TYPE.None #TYPE

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
		STAGE.ready: 4 if type == Constants.TYPE.Corn else 3,
	}[s]
	$FarmingPlants.frame = new_frame

func trigger_increase_stage():
	if $StageTimer.is_stopped():
		$StageTimer.start()

func _on_stage_timer_timeout():
	increase_stage()

func increase_stage():
	if type == Constants.TYPE.None or stage == STAGE.ready:
		return

	var new_stage = {
		STAGE.empty: STAGE.sprout,
		STAGE.sprout: STAGE.growing,
		STAGE.growing: STAGE.showing,
		STAGE.showing: STAGE.corn if type == Constants.TYPE.Corn else STAGE.ready,
		STAGE.corn: STAGE.ready,
	}[stage]
	set_stage(new_stage)

func set_type(t: Constants.TYPE):
	type = t
	if type == Constants.TYPE.None:
		return
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
	$FarmingPlants.position = Vector2(0, -12 if type == Constants.TYPE.Corn else -5)
	$FarmingPlants.vframes = 1
	$FarmingPlants.frame = 0

func _on_button_pressed():
	Events.select_garden_plot.emit(self)
