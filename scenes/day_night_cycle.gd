extends Node

var hour = 9
var am_pm = Constants.TIME.AM

var become_day = [6, Constants.TIME.AM]
var become_night = [9, Constants.TIME.PM] # [12, Constants.TIME.PM] #

func _ready():
	$HourTimer.wait_time = Constants.SETTINGS_HOUR_DURATION_NORMAL
	$HourTimer.start()
	Events.open_menu.connect(_handle_event_open_menu)
	Events.close_menu.connect(_handle_event_close_menu)
	Events.time_passage_fast_forward.connect(_handle_event_time_passage_fast_forward)
	Events.time_passage_play.connect(_handle_event_time_passage_play)
	Events.time_passage_pause.connect(_handle_event_time_passage_pause)

func _handle_event_time_passage_fast_forward():
	$HourTimer.paused = false
	$HourTimer.wait_time = Constants.SETTINGS_HOUR_DURATION_FAST
	$HourTimer.start()

func _handle_event_time_passage_play():
	$HourTimer.paused = false
	$HourTimer.wait_time = Constants.SETTINGS_HOUR_DURATION_NORMAL
	$HourTimer.start()

func _handle_event_time_passage_pause():
	$HourTimer.paused = true

func _handle_event_open_menu(_stats, _is_workstation):
	$HourTimer.paused = true

func _handle_event_close_menu():
	$HourTimer.paused = false

func _on_hour_timer_timeout():
	print('an hour has passed')
	increase_hour()

func increase_hour():
	hour += 1
	if hour == 12:
		if am_pm == Constants.TIME.AM:
			am_pm = Constants.TIME.PM
		else:
			am_pm = Constants.TIME.AM
			Events.start_new_day.emit()

	if hour == 13:
		hour = 1

	if hour == become_day[0] and am_pm == become_day[1]:
		Events.become_day.emit()
	
	if hour == become_night[0] and am_pm == become_night[1]:
		Events.become_night.emit()
	
	Events.increase_hour.emit(hour, am_pm)
