class_name GardenPlotState
extends Resource

@export var type : Constants.VEGETABLE_TYPE = Constants.VEGETABLE_TYPE.None #TYPE


@export var stage : Constants.STAGE = Constants.STAGE.empty

@export var harvest_yield: int
@export var harvested = 0
@export var was_watered = false
@export var just_sown = false
@export var coordinates: Vector2i
