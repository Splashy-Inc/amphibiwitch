extends Node

signal menu_requested(menu_name: String)
signal screen_requested(location_name: LocationData.Name)
signal player_exited_screen
signal inventory_updated(data: InventoryData)
