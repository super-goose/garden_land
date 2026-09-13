class_name GameData
extends Resource

@export var show_tutorials = true

func to_dict():
	return {
		'show_tutorials': show_tutorials
	}

static func from_dict(data: Dictionary) -> GameData:
	var g = GameData.new()
	g.show_tutorials = data['show_tutorials']
	return g
