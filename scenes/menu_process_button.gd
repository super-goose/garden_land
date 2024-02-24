extends MarginContainer

var callback : Callable

func set_functionality(_callback: Callable):
	callback = _callback

func _on_button_pressed():
	if callback:
		callback.call()
