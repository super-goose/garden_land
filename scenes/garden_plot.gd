class_name GardenPlot
extends Area2D

var state: GardenPlotState


var Vegetable = load("res://scenes/vegetable.tscn")

func _ready():
	Events.start_new_day.connect(_handle_event_start_new_day)
	Events.stop_raining.connect(_handle_event_stop_raining)
	update_visuals()

func update_visuals():
	#if state.coordinates == Vector2i(29, 30):
		#breakpoint
	$FarmingPlants.visible = state.stage != Constants.STAGE.empty
	if state.type != Constants.VEGETABLE_TYPE.None:
		$FarmingPlants.texture = Constants.GROW_SPRITES[state.type]
		$FarmingPlants.hframes = 5 if state.type == Constants.VEGETABLE_TYPE.Corn else 4
		$FarmingPlants.position = Vector2(0, -12 if state.type == Constants.VEGETABLE_TYPE.Corn else -5)
		$FarmingPlants.vframes = 1
		var new_frame = {
			Constants.STAGE.empty: -1,
			Constants.STAGE.sprout: 0,
			Constants.STAGE.growing: 1,
			Constants.STAGE.showing: 2,
			Constants.STAGE.corn: 3,
			Constants.STAGE.ready: 4 if state.type == Constants.VEGETABLE_TYPE.Corn else 3,
		}[state.stage]
		$FarmingPlants.frame = new_frame
	$Watered.visible = state.was_watered
	$Sown.visible = state.just_sown
	
func update_plot():
	update_visuals()
	Events.update_garden_plot.emit(state)


func set_stage(s: Constants.STAGE):
	state.stage = s
	update_plot()

func get_watered():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	state.was_watered = true
	update_plot()

func _handle_event_start_new_day():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	if state.was_watered:
		increase_stage()
	state.was_watered = false
	update_plot()

func _handle_event_stop_raining():
	get_watered()

func increase_stage():
	if state.type == Constants.VEGETABLE_TYPE.None or state.stage == Constants.STAGE.ready:
		return
	
	state.just_sown = false
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
	state.just_sown = true

	var harvest_range = Constants.HARVEST_YIELD_RANGES_BY_VEGETABLE_TYPE[state.type]
	state.harvest_yield = Dice.roll_d_range(harvest_range[0], harvest_range[1])
	state.harvested = 0
	
	update_plot()

func _on_button_pressed():
	Events.select_garden_plot.emit(self)

func is_ready():
	return state.stage == Constants.STAGE.ready

func harvest():
	if state.type == Constants.VEGETABLE_TYPE.None:
		return
	state.stage = Constants.STAGE.showing
	Events.vegetable_was_harvested.connect(_handle_event_vegetable_was_harvested) #??
	for i in range(state.harvest_yield):
		var v = Vegetable.instantiate()
		v.set_vegetable_data(state.type, i)
		add_child(v)
	


func _handle_event_vegetable_was_harvested():
	state.harvested = state.harvested + 1
	if state.harvested == state.harvest_yield:
		set_type(Constants.VEGETABLE_TYPE.None)
		print('notify the player that the plant is spent')

	update_plot()

func get_harvest_action():
	return Constants.HARVEST_ACTIONS_BY_VEGETABLE_TYPE[state.type]
