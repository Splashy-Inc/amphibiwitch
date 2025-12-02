extends Node

signal menu_requested(menu_name: String)
signal screen_requested(location_name: LocationData.Name)
signal player_exited_screen
signal inventory_updated(data: InventoryData)
signal frog_caught(frog: Frog)
signal frog_ability_used(ability: FrogAbility)
signal release_to_level(node: Node2D)

var current_inventory_data := preload("res://Custom Resources/Inventory/player_inventory.tres")

func _ready() -> void:
	inventory_updated.connect(_on_inventory_updated)
	frog_caught.connect(_on_frog_caught)

func get_current_inventory() -> InventoryData:
	return current_inventory_data

func _on_inventory_updated(new_inventory_data: InventoryData):
	current_inventory_data = new_inventory_data

func _on_frog_caught(frog: Frog):
	current_inventory_data.add_item(frog.item_data)
	inventory_updated.emit(current_inventory_data)
