extends CanvasLayer

var is_daytime = true
var rained_already
var chance_of_rain
var chance_of_stopping

func _ready():
	Events.increase_hour.connect(increase_hour)
	Events.start_new_day.connect(start_new_day)
	start_new_day()

func start_new_day():
	rained_already = false
	chance_of_rain = Dice.roll_d_range(
		Constants.SETTINGS_CHANCE_OF_RAIN_MIN,
		Constants.SETTINGS_CHANCE_OF_RAIN_MAX,
	)
	chance_of_stopping = Dice.roll_d_range(
		Constants.SETTINGS_CHANCE_OF_STOPPING_MIN,
		Constants.SETTINGS_CHANCE_OF_STOPPING_MAX,
	)

func increase_hour(hour, am_pm):
	if hour == 7 and am_pm == Constants.TIME.AM:
		is_daytime = true
	if hour == 9 and am_pm == Constants.TIME.PM:
		is_daytime = false

	if $CPUParticles2D.emitting: # raining
		var will_it_stop = Dice.roll_d100()
		if will_it_stop < chance_of_stopping: # stop raining
			$CPUParticles2D.emitting = false
			Events.stop_raining.emit()
		else:
			chance_of_stopping += 5
	else: # not raining
		if rained_already or not is_daytime:
			return
		var will_it_rain = Dice.roll_d100()
		if will_it_rain < chance_of_rain: # start raining
			rained_already = true
			$CPUParticles2D.emitting = true
			Events.start_raining.emit()
		else:
			chance_of_rain += 1
