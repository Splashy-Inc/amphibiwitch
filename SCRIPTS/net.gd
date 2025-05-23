extends Node2D

class_name Net

@onready var net_collider: CollisionPolygon2D = $NetArea/CollisionPolygon2D

@export var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	net_collider.disabled = not active
