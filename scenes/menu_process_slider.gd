class_name ProcessingSlider
extends MarginContainer

var callback : Callable
var cancel : Callable

func set_functionality(_callback: Callable, _cancel: Callable):
	callback = _callback
	cancel = _cancel

func set_max_value(max_amount: int):
	var slider = $MarginContainer/VBoxContainer/HBoxContainer/HSlider
	slider.max_value = max_amount
	slider.value = 1
	set_words(1)

func set_words(amount: int):
	$MarginContainer/VBoxContainer/Label.text = "%s selected" % amount

func _on_affirm_button_pressed():
	if callback:
		var slider = $MarginContainer/VBoxContainer/HBoxContainer/HSlider
		callback.call(slider.value)


func _on_deny_button_pressed():
	if cancel:
		cancel.call()


func _on_h_slider_value_changed(value: float) -> void:
	set_words(int(value))
