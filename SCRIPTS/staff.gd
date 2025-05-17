extends Node2D

class_name Staff

@onready var active_light: PointLight2D = $ActiveLightArea/ActiveLight
@onready var active_area: CollisionPolygon2D = $ActiveLightArea/CollisionPolygon2D
@onready var passive_light: PointLight2D = $PassiveLight


var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	active_light.visible = active
	active_area.disabled = not active


func _on_active_light_area_body_entered(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(true)

func _on_active_light_area_body_exited(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(false)
