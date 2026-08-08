class_name Quest
extends Resource

## Name of the quest, displayed to the user
@export var name: String

## Quests that must be completed before this one becomes available
@export var prerequisite: Array[Quest]

## The letter contents the user will read
@export_multiline var blurb: String

## Notes for the developer
@export_multiline var note: String

## Deliverables the user must provide in order to fulfill the quest
@export var required_items: Array[InventoryItem]

## Gold, items, etc the user gets for completing the quest
@export var reward: Reward 

## Whether or not the quest is active currently
@export var active: bool = false

## Whether or not the quest has been read
@export var has_read: bool = false

## Whether or not the quest is complete
@export var completed: bool = false
