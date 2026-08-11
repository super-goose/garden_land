class_name Quest
extends Resource

## Name of the quest, displayed to the user
@export var name: String

## Programmatic name of the quest
@export var real_name: QuestConstants.Name

## Quests that must be completed before this one becomes available
@export var prerequisite: Array[QuestConstants.Name] = []

## The letter contents the user will read
@export_multiline var blurb: String

## Notes for the developer
@export_multiline var note: String

## Supplies (seeds) the user can use to fulfill the request
@export var supplies_seeds: Array[InventoryItemVegetable]

## Supplies (equipment) the user can use to fulfill the request
@export var supplies_equipment: Array[Constants.TOOL_TYPE]

## Deliverables (vegetables) the user must provide in order to fulfill the quest
#@export var required_vegetables: Array[InventoryItem]
@export var required_vegetables: Array[InventoryItemVegetable]

## Deliverables (fruit) the user must provide in order to fulfill the quest
@export var required_fruit: Array[InventoryItemFruit]

## Deliverables (consumables) the user must provide in order to fulfill the quest
@export var required_consumables: Array[InventoryItemConsumable]

## Gold, items, etc the user gets for completing the quest
@export var reward: Reward 

## Whether or not the quest is available currently
@export var available: bool

## Whether or not the quest is active currently
@export var active: bool

## Whether or not the quest has been read
@export var has_read: bool

## Whether or not the quest is complete
@export var completed: bool
