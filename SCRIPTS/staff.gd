extends Node2D

class_name Staff

@onready var active_light: PointLight2D = $ActiveLightArea/ActiveLight
@onready var active_area: CollisionPolygon2D = $ActiveLightArea/CollisionPolygon2D
@onready var passive_light: PointLight2D = $PassiveLight

const energy_use_per_second = .3

var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var energy_mod = 2.0
	if active:
		energy_mod = -1.0
	passive_light.energy = clamp(passive_light.energy + delta * energy_mod * energy_use_per_second, 0.0, 1.0)
	active_light.energy = passive_light.energy
	active_light.visible = active and passive_light.energy > 0.0
	active_area.disabled = not active_light.visible
	


func _on_active_light_area_body_entered(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(true)

func _on_active_light_area_body_exited(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(false)
