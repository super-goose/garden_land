class_name GardenData
extends Resource

@export var dirt_tiles: Array[Vector2i]
@export var plot_states: Dictionary = {}
@export var start_location: Vector2i

func to_dict():
	var dirt_tiles_ = []
	for tile in dirt_tiles:
		dirt_tiles_.append([tile.x, tile.y])

	var plot_states_ = {}
	for pos in plot_states:
		plot_states_[[pos.x, pos.y]] = plot_states[pos].to_dict()

	return {
		"dirt_tiles": dirt_tiles_,
		"plot_states": plot_states_,
		"start_location": [start_location.x, start_location.y],
	}

static func from_dict(data: Dictionary) -> GardenData:
	var garden_data = GardenData.new()

	var dirt_tiles_: Array[Vector2i] = []
	for tile in data["dirt_tiles"]:
		dirt_tiles_.append(Vector2i(tile[0], tile[1]))
	garden_data.dirt_tiles = dirt_tiles_

	var plot_states_ = {}
	for pos in data["plot_states"]:
		plot_states_[Vector2i(int(pos[0]), int(pos[1]))] = GardenPlotState.from_dict(data["plot_states"][pos])
	garden_data.plot_states = plot_states_

	var start_location_ = data["start_location"]
	garden_data.start_location = Vector2i(start_location_[0], start_location_[1])

	return garden_data
