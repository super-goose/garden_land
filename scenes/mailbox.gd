class_name Mailbox
extends Node2D


var has_mail = false

func _ready():
	Events.quest_available.connect(_handle_event_quest_available)

func _handle_event_quest_available():
	$AnimatedSprite2D.play("mail-alert")

func _on_button_pressed():
	Events.select_mailbox.emit(self)

func _on_area_2d_area_entered(area):
	if has_mail:
		$AnimatedSprite2D.play('clear-alert')
		has_mail = false
	else:
		$AnimatedSprite2D.play('open')

func _on_area_2d_area_exited(area):
	$AnimatedSprite2D.play('close')
