class_name QuestConstants
extends Node

enum Name {
	BeginnerCarrots,
	BeginnerStew,
}

static var REWARD = {
	Name.BeginnerCarrots: Reward.new(20, [
		InventoryItemVegetable.build(Constants.VEGETABLE_TYPE.Carrot, 5)
	], []),
	Name.BeginnerStew: Reward.new(20, [
		InventoryItemVegetable.build(Constants.VEGETABLE_TYPE.Potato, 5)
	], [
		Constants.TOOL_TYPE.Axe
	])
}
