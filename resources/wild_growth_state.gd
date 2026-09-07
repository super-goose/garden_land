class_name WildGrowthState
extends Resource

@export var trees: Dictionary = {}

#var bushes: Dictionary = {}

func to_dict() -> Dictionary:
	var tree_states = {}
	for pos in trees:
		tree_states[[pos.x, pos.y]] = trees[pos].to_dict()
	
	return {
		"trees": tree_states
	}


static func from_dict(data: Dictionary) -> WildGrowthState:
	var w = WildGrowthState.new()
	
	for pos_str in data["trees"]:
		var pos = JSON.parse_string(pos_str)
	
		w.trees[Vector2i(int(pos[0]), int(pos[1]))] = FruitTreeState.from_dict(data["trees"][pos_str])
	
	return w
