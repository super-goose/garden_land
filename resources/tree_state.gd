class_name FruitTreeState
extends Resource

const MAX_HP = 3
const TYPES = ['apple', 'orange', 'peach', 'pear', 'none']

## the type of the tree (apple, pear, none, etc)
@export var type : String

## the sprite to display (an apple tree with no apples looks like a "none" tree)
@export var display_type : String

## the last time the tree hp changed; used to determine if the tree will heal
@export var hp_related_timestamp = null

## current HP of the tree
@export var hp = MAX_HP

## essentially, whether or not the tree was chopped down already
@export var is_intact = true

func set_new_types():
	type = TYPES[Dice.roll_dn(TYPES.size()) - 1]
	display_type = type

func to_dict() -> Dictionary:
	return {
		'type': type,
		'display_type': display_type,
		'hp_related_timestamp': hp_related_timestamp,
		'hp': hp,
		'is_intact': is_intact,
	}

static func from_dict(data):
	var ft = FruitTreeState.new()
	ft.type = data['type']
	ft.display_type = data['display_type']
	ft.hp_related_timestamp = data['hp_related_timestamp']
	ft.hp = data['hp']
	ft.is_intact = data['is_intact']
	return ft
