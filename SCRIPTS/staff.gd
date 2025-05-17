extends Node2D

class_name Staff

@onready var active_light: PointLight2D = $ActiveLight
@onready var passive_light: PointLight2D = $PassiveLight

var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	active_light.visible = active
