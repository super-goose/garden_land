extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.increase_hour.connect(increase_hour)

func increase_hour():
	pass
