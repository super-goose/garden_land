class_name QuestDetailsComponent
extends MarginContainer

var ItemLabel = load("res://scenes/ui_components/dark_label.tscn")
var VerticalSeparator = load("res://scenes/ui_components/vertical_separator.tscn")

func set_label(text: String):
	$HBoxContainer/MarginContainer/VBoxContainer/Label.text = text

func set_items_and_counts(items: Array):
	var item_container = $HBoxContainer/MarginContainer/VBoxContainer/ItemsHBox
	for child in item_container.get_children():
		item_container.remove_child(child)

	var use_separator = false
	for item in items:
		if use_separator:
			var separator = VerticalSeparator.instantiate()
			item_container.add_child(separator)
		else:
			use_separator = true
		
		var texture_rect = TextureRect.new()
		texture_rect.texture = item['texture']
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
		item_container.add_child(texture_rect)
		
		var item_label = Label.new()
		item_label.text = "%s" % item['count']
		item_label.add_theme_color_override('font_color', Color.BLACK)
		item_container.add_child(item_label)
