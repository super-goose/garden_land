class_name _GardenPlot
extends Node2D

enum TYPE {
	_corn, _still_corn, carrot, cauliflower, tomato,
	eggplant, _blue_flower, lettuce, wheat, pumpkin,
	parsnip, _rose, beet, _star_fruit, cucumber
}
@export var type : TYPE = TYPE._still_corn

enum STAGE { sprout, growing, showing, ready, corn }
@export var stage : STAGE = STAGE.showing


# Called when the node enters the scene tree for the first time.
func _ready():
	print(int(type))
	print(int(stage))
	
	pass # Replace with function body.

func calculate_frame():
	return (int(type) * 5) + int(stage)

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

