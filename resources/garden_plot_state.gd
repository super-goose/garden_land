class_name GardenPlotState
extends Resource

var type : Constants.VEGETABLE_TYPE = Constants.VEGETABLE_TYPE.None #TYPE


var stage : Constants.STAGE = Constants.STAGE.empty

var harvest_yield: int
var harvested = 0
var was_watered = false
var coordinates: Vector2i
