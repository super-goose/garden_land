extends Node

var day_color = Color(1, 1, 1, 0)
var night_color = Color(1, 1, 1, 1)

@onready var dusk_dawn_duration = $HourTimer.wait_time
var hour = 9
var am_pm = Constants.TIME.AM

var become_day = [6, Constants.TIME.AM]
var become_night = [9, Constants.TIME.PM]

func _ready():
	$HourTimer.start()

func _on_hour_timer_timeout():
	increase_hour()

func increase_hour():
	hour += 1
	if hour == 12:
		if am_pm == Constants.TIME.AM:
			am_pm = Constants.TIME.PM
		else:
			am_pm = Constants.TIME.AM

	if hour == 13:
		hour = 1

	if hour == become_day[0] and am_pm == become_day[1]:
		Events.become_day.emit()
	
	if hour == become_night[0] and am_pm == become_night[1]:
		Events.become_night.emit()
	
	Events.increase_hour.emit(hour)
