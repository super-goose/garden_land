class_name Mailbox
extends Area2D


var has_mail = false

func _ready():
	Events.quest_available.connect(_handle_event_quest_available)
	if State.stats_and_inventory.get_next_quest():
		$AnimatedSprite2D.play("mail-alert")
	else:
		$AnimatedSprite2D.play("idle")

func _handle_event_quest_available(quest_real_name: QuestConstants.Name):
	$AnimatedSprite2D.play("mail-alert")
	if quest_real_name == QuestConstants.Name.Welcome:
		Events.set_action_tutorial.emit("check the mail")

func _on_button_pressed():
	Events.select_mailbox.emit(self)

func on_character_entered():
	if has_mail:
		$AnimatedSprite2D.play('clear-alert')
		has_mail = false
	else:
		$AnimatedSprite2D.play('open')

func on_character_exited():
	$AnimatedSprite2D.play('close')
