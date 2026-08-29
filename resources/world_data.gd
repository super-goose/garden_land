class_name WorldData
extends Resource

@export var last_processed_timestamp: int

func to_dict():
	return {
		"last_processed_timestamp": last_processed_timestamp,
	}

static func from_dict(data: Dictionary) -> WorldData:
	
	var world_data = WorldData.new()

	world_data.last_processed_timestamp = data["last_processed_timestamp"]

	return world_data
