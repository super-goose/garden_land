class_name GardenPlotState
extends Resource

@export var type : Constants.VEGETABLE_TYPE = Constants.VEGETABLE_TYPE.None #TYPE


@export var stage : Constants.STAGE = Constants.STAGE.empty

@export var harvest_yield: int
@export var harvested = 0
@export var was_watered = false
@export var just_sown = false
@export var coordinates: Vector2i
@export var stage_change_timestamp: int

func to_dict():
	return {
		"type": type,
		"stage": stage,
		"harvest_yield": harvest_yield,
		"harvested": harvested,
		"was_watered": was_watered,
		"just_sown": just_sown,
		"coordinates": [coordinates.x, coordinates.y],
		"stage_change_timestamp": stage_change_timestamp,
	}

static func from_dict(data: Dictionary) -> GardenPlotState:
	var plot_state = GardenPlotState.new()

	plot_state.type = data["type"]
	plot_state.stage = data["stage"]
	plot_state.harvest_yield = data["harvest_yield"]
	plot_state.harvested = data["harvested"]
	plot_state.was_watered = data["was_watered"]
	plot_state.just_sown = data["just_sown"]
	plot_state.coordinates = Vector2i(data["coordinates"][0], data["coordinates"][1])
	plot_state.stage_change_timestamp = data["stage_change_timestamp"]

	return plot_state
