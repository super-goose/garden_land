class_name GardenPlot
extends Area2D

enum TYPE {
	_corn, _still_corn, carrot, cauliflower, tomato,
	eggplant, _blue_flower, lettuce, wheat, pumpkin,
	parsnip, _rose, beet, _star_fruit, cucumber
}
@export var type : TYPE = TYPE._still_corn

enum STAGE { empty, sprout, growing, showing, ready, corn }
@export var stage : STAGE = STAGE.showing

@export var debug_name : String = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	print(int(type))
	print(int(stage))
	$FarmingPlants.visible = stage != STAGE.empty
	$FarmingPlants.frame = (int(type) * 5) + int(stage)
	
	pass # Replace with function body.

func calculate_frame():
	return (int(type) * 5) + int(stage)

func set_stage(s: STAGE):
	stage = s
	$FarmingPlants.visible = stage != STAGE.empty
	$FarmingPlants.frame = (int(type) * 5) + int(stage) - 1

func increase_stage():
	print('increasing stage for %s' % debug_name)
	if stage == STAGE.ready:
		return
	var new_stage = {
		STAGE.empty: STAGE.sprout,
		STAGE.sprout: STAGE.growing,
		STAGE.growing: STAGE.showing,
		STAGE.showing: STAGE.ready,
	}[stage]
	set_stage(new_stage)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
"""
plants:
0 - corn
1 - still corn
2 - carrot
3 - cauliflower
4 - tomato
5 - eggplant
6 - blue flower
7 - lettuce
8 - wheat
9 - pumpkin
10 - parsnip
11 - rose maybe
12 - beet
13 - star fruit??
14 - cucumber

stages:
0 - sprout
1 - growing
2 - showing
3 - ready
4 - corn (don't use)
"""

