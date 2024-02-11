class_name ToolCell
extends Control


func set_data(type: Constants.TOOL_TYPE, amount_text: String):
	var texture = Constants.INDIVIDUAL_TOOL_BY_TOOL_TYPE[type]

	$TextureRect/TextureRect.texture = texture
	$TextureRect/Label.text = amount_text
