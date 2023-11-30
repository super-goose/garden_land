extends TextureButton

enum Actions {
	HOE,
	WATER,
	AXE,
	SOW,
}

var action: Actions
var action_image

func set_action(new_action):
	action = new_action
	action_image = {
		[Actions.HOE]: load("res://Sprout Lands - Sprites - premium pack/Objects/Items/tools-axe.png")
	}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
