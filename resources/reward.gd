class_name Reward
extends Resource

@export var gold: int

@export var seeds: Array[InventoryItemVegetable]

@export var tool: Constants.TOOL_TYPE

func _init(_gold: int, _seeds: Array[InventoryItemVegetable], _tool: Array[Constants.TOOL_TYPE]) -> void:
	gold = _gold
	if _seeds.size():
		seeds = _seeds
	if _tool.size():
		tool = _tool[0]
