class_name ProcessingButton
extends MarginContainer

var callback : Callable

func set_functionality(_callback: Callable):
	callback = _callback

func set_words(words: String):
	$Control/Label.text = words

func _on_button_pressed():
	if callback:
		callback.call()
