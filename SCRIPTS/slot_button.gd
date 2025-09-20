extends Control

class_name InventorySlot

@onready var texture_rect: TextureRect = $Button/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_data(new_data: InventorySlotData):
	if new_data and new_data.item:
		texture_rect.texture = new_data.item.icon
	else:
		texture_rect.texture = null
