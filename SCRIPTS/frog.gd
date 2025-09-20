extends CharacterBody2D

class_name Frog

signal died

enum Type {
	BASIC,
	BALFROG,
}

@export var type : Type
@export var item_data_options : Array[FrogItemData]
@export var item_data : FrogItemData

const SPEED = 300.0

var is_lit := false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var eye_shine: Node2D = $EyeShine
@onready var sfx_manager: SFXManager = $SFXManager

func _ready() -> void:
	$RibbitTimer.wait_time = randf_range(0.5, 1.0)
	died.connect(Globals._on_frog_died)
	initialize(type)

func _physics_process(delta: float) -> void:
	animated_sprite_2d.play("move")
	animated_sprite_2d.modulate.a = move_toward(animated_sprite_2d.modulate.a, float(is_lit), delta)
	if is_lit:
		var direction := -global_position.direction_to(get_tree().get_first_node_in_group("Player").global_position)
		if direction:
			velocity = direction * SPEED
			rotation = -direction.angle_to(Vector2.UP)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * 3)

	move_and_slide()

func initialize(new_type: Type):
	set_type(new_type)

func set_type(new_type: Type):
	type = new_type
	
	for data in item_data_options:
		if data.frog_data.type == type:
			item_data = data
	
	animated_sprite_2d.sprite_frames = item_data.frog_data.sprite_frames

func on_hit():
	if animated_sprite_2d.modulate.a > 0.0:
		died.emit()
		visible = false
		collision_shape_2d.disabled = true
		sfx_manager.play("Hit")
		await sfx_manager.sfx_finished
		queue_free()

func set_lit(new_lit: bool):
	if new_lit != is_lit:
		is_lit = new_lit
	eye_shine.visible = is_lit

func _on_ribbit_timer_timeout() -> void:
	if randi_range(0, 10) == 0:
		sfx_manager.play("Ribbit")
