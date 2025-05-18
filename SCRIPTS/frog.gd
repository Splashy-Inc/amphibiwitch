extends CharacterBody2D

class_name Frog

const SPEED = 300.0

var is_lit := false

func _physics_process(delta: float) -> void:
	modulate.a = move_toward(modulate.a, float(is_lit), delta)
	if is_lit:
		var direction := -global_position.direction_to(get_tree().get_first_node_in_group("Player").global_position)
		if direction:
			velocity = direction * SPEED
			rotation = -direction.angle_to(Vector2.UP)
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * 3)

	move_and_slide()

func on_hit():
	if modulate.a > 0.0:
		queue_free()

func set_lit(new_lit: bool):
	if new_lit != is_lit:
		is_lit = new_lit
