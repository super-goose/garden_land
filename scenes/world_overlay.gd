extends CanvasLayer

var day_color = Color(255, 255, 255, 0)
var night_color = Color(255, 255, 255, 160)

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = day_color
	$DayTimer.start()

func _on_night_timer_timeout():
	pass # Replace with function body.


func _on_day_timer_timeout():
	pass


