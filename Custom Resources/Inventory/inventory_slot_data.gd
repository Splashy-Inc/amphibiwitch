extends Resource

class_name InventorySlotData

@export var item : InventoryItemData
@export var count := 0

func add_item(new_item: InventoryItemData):
	var is_success := false
	if item == null or new_item.name == item.name:
		item = new_item
		count += 1
		is_success = true
	
	return is_success

func remove_item(new_item: InventoryItemData):
	var is_success := false
	if count > 0 and new_item.name == item.name:
		count -= 1
		is_success = true
		
	if count <= 0:
		item = null
		
	return is_success
