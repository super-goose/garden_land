extends Node

var hour = 9
var am_pm = Constants.TIME.AM

var become_day = [5, Constants.TIME.AM]
var become_night = [11, Constants.TIME.PM] # [12, Constants.TIME.PM] #

func _ready():
	$HourTimer.wait_time = Constants.SETTINGS_HOUR_DURATION_NORMAL
	$HourTimer.start()
	Events.open_menu.connect(_handle_event_open_menu)
	Events.close_menu.connect(_handle_event_close_menu)
	Events.time_passage_fast_forward.connect(_handle_event_time_passage_fast_forward)
	Events.time_passage_play.connect(_handle_event_time_passage_play)
	Events.time_passage_pause.connect(_handle_event_time_passage_pause)
	Events.go_to_bed.connect(_handle_event_go_to_bed)
	#if State.world_needs_processing:
		#play_catch_up_with_the_world()

func _handle_event_go_to_bed():
	Events.darken_for_bedtime.emit()
	am_pm = Constants.TIME.AM
	hour = 7
	$HourTimer.start()


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

func play_catch_up_with_the_world():
	var now = int(Time.get_unix_time_from_system())
	breakpoint
	while State.world_data.last_processed_timestamp < now:
		State.world_data.last_processed_timestamp += int($HourTimer.wait_time)
		Events.tick.emit(State.world_data.last_processed_timestamp)

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
	var now = int(Time.get_unix_time_from_system())
	Events.tick.emit(now)
	#State.world_data.last_processed_timestamp = now
	State.save_save_file()
	
