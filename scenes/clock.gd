extends MarginContainer

var hour_frame = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

var controls_visible = false
var state_of_time_passage = 'normal'

func _ready():
	Events.increase_hour.connect(increase_hour)
	set_control_visibility()

func toggle_control_visibility():
	controls_visible = !controls_visible
	set_control_visibility()
	set_control_appearance()

func set_control_visibility():
	$VBoxContainer/TextureFastForward.visible = controls_visible
	$VBoxContainer/TexturePause.visible = controls_visible
	$VBoxContainer/TexturePlay.visible = controls_visible

func set_control_appearance():
	var fast_forward = Rect2(0, 16, 16, 16) if state_of_time_passage == 'fast' else Rect2(0, 0, 16, 16)
	$VBoxContainer/TextureFastForward.texture.region = fast_forward

	var pause = Rect2(0, 16, 16, 16) if state_of_time_passage == 'paused' else Rect2(0, 0, 16, 16)
	$VBoxContainer/TexturePause.texture.region = pause

	var play = Rect2(0, 16, 16, 16) if state_of_time_passage == 'normal' else Rect2(0, 0, 16, 16)
	$VBoxContainer/TexturePlay.texture.region = play

func increase_hour(hour: int, _am_pm):
	var x = 16 * hour_frame.find(hour)
	$VBoxContainer/TextureClock.texture.region = Rect2(x, 0, 16, 16)

func _on_clock_button_pressed():
	toggle_control_visibility()

func _on_play_button_pressed():
	Events.time_passage_play.emit()
	state_of_time_passage = 'normal'
	set_control_appearance()

func _on_fast_forward_button_pressed():
	Events.time_passage_fast_forward.emit()
	state_of_time_passage = 'fast'
	set_control_appearance()

func _on_pause_button_pressed():
	Events.time_passage_pause.emit()
	state_of_time_passage = 'paused'
	set_control_appearance()
