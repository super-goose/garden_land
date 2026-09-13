class_name QuestConstants
extends Node

enum Name {
	Welcome,
	BeginnerCarrots,
	BeginnerStew,
}

static var REWARD = {
	Name.Welcome: Reward.new(0, [
		InventoryItemVegetable.build(Constants.VEGETABLE_TYPE.Lettuce, 5)
	], [
		Constants.TOOL_TYPE.Hoe
	]),
	Name.BeginnerCarrots: Reward.new(20, [
		InventoryItemVegetable.build(Constants.VEGETABLE_TYPE.Carrot, 5)
	], []),
	Name.BeginnerStew: Reward.new(20, [
		InventoryItemVegetable.build(Constants.VEGETABLE_TYPE.Potato, 5)
	], [
		Constants.TOOL_TYPE.Axe
	])
}
