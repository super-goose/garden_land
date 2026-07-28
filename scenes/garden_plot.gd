class_name GardenPlot
extends Area2D

var state: GardenPlotState = GardenPlotState.new()


var Vegetable = load("res://scenes/vegetable.tscn")

func _ready():
	Events.start_new_day.connect(_handle_event_start_new_day)
	Events.stop_raining.connect(_handle_event_stop_raining)
	$FarmingPlants.visible = state.stage != Constants.STAGE.empty
	$FarmingPlants.frame = 0

func set_stage(s: Constants.STAGE):
	state.stage = s
	$FarmingPlants.visible = state.stage != Constants.STAGE.empty
	var new_frame = {
		Constants.STAGE.empty: -1,
		Constants.STAGE.sprout: 0,
		Constants.STAGE.growing: 1,
		Constants.STAGE.showing: 2,
		Constants.STAGE.corn: 3,
		Constants.STAGE.ready: 4 if state.type == Constants.VEGETABLE_TYPE.Corn else 3,
	}[s]
	$FarmingPlants.frame = new_frame
	# TODO: emit save signal

func get_watered():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	state.was_watered = true
	$Watered.visible = true

func _handle_event_start_new_day():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	if state.was_watered:
		increase_stage()
	state.was_watered = false
	$Watered.visible = false

func _handle_event_stop_raining():
	get_watered()

func increase_stage():
	if state.type == Constants.VEGETABLE_TYPE.None or state.stage == Constants.STAGE.ready:
		return

	$Sown.visible = false
	var new_stage = {
		Constants.STAGE.empty: Constants.STAGE.sprout,
		Constants.STAGE.sprout: Constants.STAGE.growing,
		Constants.STAGE.growing: Constants.STAGE.showing,
		Constants.STAGE.showing: Constants.STAGE.corn if state.type == Constants.VEGETABLE_TYPE.Corn else Constants.STAGE.ready,
		Constants.STAGE.corn: Constants.STAGE.ready,
	}[state.stage]
	set_stage(new_stage)
	await get_tree().create_timer(.3).timeout
	Events.update_actions.emit()

func set_type(t: Constants.VEGETABLE_TYPE):
	state.type = t
	if state.type == Constants.VEGETABLE_TYPE.None:
		set_stage(Constants.STAGE.empty)
		return
	$Sown.visible = true
	$FarmingPlants.texture = Constants.GROW_SPRITES[state.type]
	$FarmingPlants.hframes = 5 if state.type == Constants.VEGETABLE_TYPE.Corn else 4
	$FarmingPlants.position = Vector2(0, -12 if state.type == Constants.VEGETABLE_TYPE.Corn else -5)
	$FarmingPlants.vframes = 1
	$FarmingPlants.frame = 0
	var harvest_range = Constants.HARVEST_YIELD_RANGES_BY_VEGETABLE_TYPE[state.type]
	state.harvest_yield = Dice.roll_d_range(harvest_range[0], harvest_range[1])
	state.harvested = 0

func _on_button_pressed():
	Events.select_garden_plot.emit(self)

func is_ready():
	return state.stage == Constants.STAGE.ready

func harvest():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	$FarmingPlants.frame = 2
	Events.vegetable_was_harvested.connect(_handle_event_vegetable_was_harvested)
	for i in range(state.harvest_yield):
		var v = Vegetable.instantiate()
		v.set_vegetable_data(state.type, i)
		add_child(v)


func _handle_event_vegetable_was_harvested():
	state.harvested = state.harvested + 1
	if state.harvested == state.harvest_yield:
		set_type(Constants.VEGETABLE_TYPE.None)

func get_harvest_action():
	return Constants.HARVEST_ACTIONS_BY_VEGETABLE_TYPE[state.type]
