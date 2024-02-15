extends CanvasLayer

var day_color = Color(1, 1, 1, 0)
var night_color = Color(1, 1, 1, 1)

var hour = 9
var am_pm = Constants.TIME.AM

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/CanvasModulate.color = day_color
	$HourTimer.start()

func _on_hour_timer_timeout():
	increase_hour()

func night_becomes_day():
	print('night becomes day')
	var t = create_tween()
	t.tween_property($ColorRect/CanvasModulate, 'color', day_color, 1)

func day_becomes_night():
	print('day becomes night')
	var t = create_tween()
	t.tween_property($ColorRect/CanvasModulate, 'color', night_color, 1)

func increase_hour():
	hour += 1
	if hour == 12:
		if am_pm == Constants.TIME.AM:
			am_pm = Constants.TIME.PM
		else:
			am_pm = Constants.TIME.AM

	if hour == 13:
		hour = 1

	if hour == 6 and am_pm == Constants.TIME.AM:
		night_becomes_day()
	
	if hour == 9 and am_pm == Constants.TIME.PM:
		day_becomes_night()
	
