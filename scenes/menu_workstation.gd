extends Control

func _ready():
	Events.open_workstation_menu.connect(open_menu)

func open_menu(stats: StatsAndInventory):
	visible = true

func _on_close_button_pressed():
	visible = false
	Events.close_menu.emit()
