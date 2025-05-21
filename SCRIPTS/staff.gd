extends Node2D

class_name Staff

@onready var active_light: Sprite2D = $ActiveLightArea/ActiveLightSprite
@onready var active_area: CollisionPolygon2D = $ActiveLightArea/CollisionPolygon2D
@onready var passive_light: Sprite2D = $PassiveLightSprite
@onready var active_sound: AudioStreamPlayer = $ActiveSound
@onready var tile_map_background: Node2D = $TileMapBackground


const energy_use_per_second = .3
var energy = 1.0

var active := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_map_background.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var energy_mod = 2.0
	if active:
		energy_mod = -1.0
	energy = clamp(energy + delta * energy_mod * energy_use_per_second, 0.0, 1.0)
	active_light.material.set_shader_parameter("modulate", energy)
	passive_light.material.set_shader_parameter("modulate", energy)
	active_light.visible = active and energy > 0.0
	active_area.disabled = not active_light.visible
	if active_sound.playing != active_light.visible:
		active_sound.playing = active_light.visible
	


func _on_active_light_area_body_entered(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(true)

func _on_active_light_area_body_exited(body: Node2D) -> void:
	if body is Frog:
		body.set_lit(false)
