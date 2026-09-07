class_name FruitTreeState
extends Resource

const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']

@export var type : String

@export var display_type : String

func set_new_types():
	type = TYPES[Dice.roll_dn(TYPES.size()) - 1]
	display_type = type

func to_dict() -> Dictionary:
	return {
		'type': type,
		'display_type': display_type,
	}

static func from_dict(data):
	var ft = FruitTreeState.new()
	ft.type = data['type']
	ft.display_type = data['display_type']
	return ft
