extends MarginContainer

var hour_frame = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.increase_hour.connect(increase_hour)

func increase_hour(hour: int):
	var x = 16 * hour_frame.find(hour)
	$TextureRect.texture.region = Rect2(x, 0, 16, 16)
