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
@export var required_vegetables: Array[InventoryItemVegetable]

## Deliverables (fruit) the user must provide in order to fulfill the quest
@export var required_fruit: Array[InventoryItemFruit]

## Deliverables (consumables) the user must provide in order to fulfill the quest
@export var required_consumables: Array[InventoryItemConsumable]

### Gold, items, etc the user gets for completing the quest
#@export var reward: Reward 

## Whether or not the quest is available currently
@export var available: bool

## Whether or not the quest is active currently
@export var active: bool

## Whether or not the quest has been read
@export var has_read: bool

## Whether or not the quest is complete
@export var completed: bool

func to_dict():
	var inv_veg_to_dict = func inv_seed_to_dict(iiv: InventoryItemVegetable):
		return {
			"vegetable": iiv.vegetable,
			"count": iiv.count,
		}
	var inv_fruit_to_dict = func inv_seed_to_dict(iif: InventoryItemFruit):
		return {
			"fruit": iif.fruit,
			"count": iif.count,
		}
	var inv_consumable_to_dict = func inv_seed_to_dict(iic: InventoryItemConsumable):
		return {
			"consumable": iic.consumable,
			"count": iic.count,
		}

	return {
		"name": name, #: String
		"real_name": real_name, #: QuestConstants.Name
		"prerequisite": prerequisite, #: Array[QuestConstants.Name] = []
		"blurb": blurb, #: String
		"note": note, #: String
		"supplies_seeds": supplies_seeds.map(inv_veg_to_dict), #: Array[InventoryItemVegetable]
		"supplies_equipment": supplies_equipment, #: Array[Constants.TOOL_TYPE]
		"required_vegetables": required_vegetables.map(inv_veg_to_dict), #: Array[InventoryItemVegetable]
		"required_fruit": required_fruit.map(inv_fruit_to_dict), #: Array[InventoryItemFruit]
		"required_consumables": required_consumables.map(inv_consumable_to_dict), #: Array[InventoryItemConsumable]
		"available": available, #: bool
		"active": active, #: bool
		"has_read": has_read, #: bool
		"completed": completed, #: bool
	}

static func from_dict(dict: Dictionary) -> Quest:
	var quest = Quest.new()
	quest.name = dict["name"]
	quest.real_name = dict["real_name"]
	quest.prerequisite = Array(dict["prerequisite"], TYPE_INT, "", null)
	quest.blurb = dict["blurb"]
	quest.note = dict["note"]
	#quest.supplies_seeds = dict["supplies_seeds"].map(InventoryItemVegetable.from_dict) as Array[InventoryItemVegetable]
	quest.supplies_seeds = Array(
		dict["supplies_seeds"].map(InventoryItemVegetable.from_dict),
		TYPE_OBJECT,
		"Resource",
		InventoryItemVegetable,
	)
	quest.supplies_equipment = Array(dict["supplies_equipment"], TYPE_INT, "", null)
	#quest.required_vegetables = dict["required_vegetables"].map(InventoryItemVegetable.from_dict)
	#quest.required_fruit = dict["required_fruit"].map(InventoryItemFruit.from_dict)
	#quest.required_consumables = dict["required_consumables"].map(InventoryItemConsumable.from_dict)
	quest.required_vegetables = Array(
		dict["required_vegetables"].map(InventoryItemVegetable.from_dict),
		TYPE_OBJECT, "Resource", InventoryItemVegetable
	)
	quest.required_fruit = Array(
		dict["required_fruit"].map(InventoryItemFruit.from_dict),
		TYPE_OBJECT, "Resource", InventoryItemFruit
	)
	quest.required_consumables = Array(
		dict["required_consumables"].map(InventoryItemConsumable.from_dict),
		TYPE_OBJECT, "Resource", InventoryItemConsumable
	)
	quest.available = dict["available"]
	quest.active = dict["active"]
	quest.has_read = dict["has_read"]
	quest.completed = dict["completed"]
	return quest
