extends Node2D

class_name FrogAbility

signal animation_finished
signal target_hit(body: Node2D)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate():
	animation_player.play("tongue")

func _on_hitbox_body_entered(body: Node2D) -> void:
	target_hit.emit(body)
