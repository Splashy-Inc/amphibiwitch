extends Control

class_name Inventory

@export var slot_scene : PackedScene
@onready var slots_h_box: HBoxContainer = $PanelContainer/SlotsHBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.inventory_updated.connect(_on_inventory_updated)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_inventory_updated(data: InventoryData):
	for slot in slots_h_box.get_children():
		slot.queue_free()
	
	for slot_data in data.slots:
		var new_slot = slot_scene.instantiate() as InventorySlot
		slots_h_box.add_child(new_slot)
		new_slot.load_data(slot_data)
