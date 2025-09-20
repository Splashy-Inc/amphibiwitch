extends TextureButton

class_name InventorySlot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_data(new_data: InventorySlotData):
	texture_normal = new_data.item.icon
