extends Node

signal appearance_changed(appearance_data: AppearanceData)
signal attribute_change_requested(attribute_data: AttributeData)

var current_appearance_data := preload("res://Custom Resources/default_appearance.tres")

func _ready() -> void:
	appearance_changed.connect(_on_appearance_changed)

func get_current_appearance() -> AppearanceData:
	return current_appearance_data

func _on_appearance_changed(new_appearance_data: AppearanceData):
	current_appearance_data = new_appearance_data
