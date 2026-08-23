extends MarginContainer

var coin_texture = load("res://modified-assets/objects/coin.png")

func populate_quest(quest: Quest):
	var quest_requirements: QuestDetailsComponent = $MarginContainer/VBoxContainer/RequirementsDetails
	var quest_rewards: QuestDetailsComponent = $MarginContainer/VBoxContainer/HBoxContainer/RewardDetails
	var quest_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Label

	quest_label.text = quest.name

	var requirements = []
	for vegetable in quest.required_vegetables:
		requirements.push_back({
			'count': vegetable.count,
			'texture': Constants.INDIVIDUAL_PLANT_BY_VEGETABLE_TYPE[vegetable.vegetable],
		})
	quest_requirements.set_items_and_counts(requirements)

	var rewards = []

	if QuestConstants.REWARD[quest.real_name].gold > 0:
		rewards.push_back({
			'count': QuestConstants.REWARD[quest.real_name].gold,
			'texture': coin_texture,
		})
	for seed_reward in QuestConstants.REWARD[quest.real_name].seeds:
		rewards.push_back({
			'count': seed_reward.count,
			'texture': Constants.INDIVIDUAL_SEEDS_BY_SEED_TYPE[seed_reward.vegetable],
		})
	if QuestConstants.REWARD[quest.real_name].tool:
		rewards.push_back({
			'count': 1,
			'texture': Constants.INDIVIDUAL_TOOL_BY_TOOL_TYPE[QuestConstants.REWARD[quest.real_name].tool],
		})

	quest_rewards.set_items_and_counts(rewards)
