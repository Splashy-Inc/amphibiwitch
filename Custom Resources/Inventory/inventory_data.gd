extends Resource

class_name InventoryData

@export var slots : Array[InventorySlotData]

func add_item(new_item: InventoryItemData):
	# Attempt to add item to existing slot with that item in it
	for slot in slots:
		if slot.item.name == new_item.name:
			return slot.add_item(new_item)
	
	# If the above doesn't work, attempt to add item to next open slot
	for slot in slots:
		if slot.add_item(new_item):
			return true
	
	return false

func remove_item(item_to_remove: InventoryItemData):
	# Remove one from first slot that contains the item type
	for slot in slots:
		if slot.remove_item(item_to_remove):
			return true
	
	return false
