@tool
@icon("res://modified-assets/ui/action-button-letter.png")
extends Control

@export var current_quest: Quest : set = _set_current_quest

@onready var menu_header = $MarginContainer/VBoxContainer/MenuHeader
@onready var letter_content = $MarginContainer/VBoxContainer/ContentContainer/MarginContainer/MarginContainer/VBoxContainer/ScrollContainer/RichTextLabel
@onready var quest_requirements: QuestDetailsComponent = $MarginContainer/VBoxContainer/ContentContainer/MarginContainer/MarginContainer/VBoxContainer/QuestRequirements
@onready var quest_rewards: QuestDetailsComponent = $MarginContainer/VBoxContainer/ContentContainer/MarginContainer/MarginContainer/VBoxContainer/QuestRewards

var coin_texture = load("res://modified-assets/objects/coin.png")

func _set_current_quest(q: Quest):
	current_quest = q
	fill_out_letter_content()

func fill_out_letter_content():
	if not is_node_ready():
		await ready

	menu_header.set_title(current_quest.name)
	letter_content.text = current_quest.blurb
	
	quest_requirements.set_label('Requirements')
	var requirements = []
	for vegetable in current_quest.required_vegetables:
		requirements.push_back({
			'count': vegetable.count,
			'texture': Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[vegetable.vegetable],
		})
	quest_requirements.set_items_and_counts(requirements)

	quest_rewards.set_label('Reward')
	var rewards = []
	if QuestConstants.REWARD[current_quest.real_name].gold > 0:
		rewards.push_back({
			'count': QuestConstants.REWARD[current_quest.real_name].gold,
			'texture': coin_texture,
		})
	for s: InventoryItemVegetable in QuestConstants.REWARD[current_quest.real_name].seeds:
		rewards.push_back({
			'count': s.count,
			'texture': Constants.INDIVIDUAL_SEEDS_BY_SEED_TYPE[s.vegetable],
		})

	quest_rewards.set_items_and_counts(rewards)

func _ready():
	#menu_header.close_button_pressed.connect(_on_close_button_pressed)
	#menu_header.settings_button_pressed.connect(_on_settings_button_pressed)
	if not Engine.is_editor_hint():
		Events.open_letter.connect(open_letter)

	if current_quest:
		fill_out_letter_content()

func open_letter(quest: Quest):
	current_quest = quest
	print(quest.name)
	visible = true

func _on_close_button_pressed():
	visible = false
	Events.confirmation_granted.emit()
