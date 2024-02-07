class_name GardenPlot
extends Area2D

@export var type : Constants.PLANT_TYPE = Constants.PLANT_TYPE.None #TYPE

enum STAGE { empty, sprout, growing, showing, ready, corn }
@export var stage : STAGE = STAGE.empty

var harvest_yield: int
var harvested = 0

var Vegetable = load("res://scenes/vegetable.tscn")

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
	await get_tree().create_timer(.3).timeout
	Events.update_actions.emit()

func set_type(t: Constants.PLANT_TYPE):
	type = t
	if type == Constants.PLANT_TYPE.None:
		set_stage(STAGE.empty)
		return

	$FarmingPlants.texture = Constants.GROW_SPRITES[type]
	$FarmingPlants.hframes = 5 if type == Constants.PLANT_TYPE.Corn else 4
	$FarmingPlants.position = Vector2(0, -12 if type == Constants.PLANT_TYPE.Corn else -5)
	$FarmingPlants.vframes = 1
	$FarmingPlants.frame = 0
	var harvest_range = Constants.HARVEST_YIELD_RANGES_BY_PLANT_TYPE[type]
	harvest_yield = Dice.roll_d_range(harvest_range[0], harvest_range[1])
	harvested = 0

func _on_button_pressed():
	Events.select_garden_plot.emit(self)

func is_ready():
	return stage == STAGE.ready

func harvest():
	if type == Constants.PLANT_TYPE.None:
		return
	$FarmingPlants.frame = 2
	Events.vegetable_was_harvested.connect(_handle_event_vegetable_was_harvested)
	for i in range(harvest_yield):
		var v = Vegetable.instantiate()
		v.set_vegetable_data(type, i)
		add_child(v)


func _handle_event_vegetable_was_harvested():
	harvested = harvested + 1
	if harvested == harvest_yield:
		set_type(Constants.PLANT_TYPE.None)

func get_harvest_action():
	return Constants.HARVEST_ACTIONS_BY_PLANT_TYPE[type]
