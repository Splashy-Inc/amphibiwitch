extends CharacterBody2D

class_name Frog

const SPEED = 200.0

var is_lit := false

func _physics_process(delta: float) -> void:
	modulate.a = move_toward(modulate.a, float(is_lit), delta)
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func on_hit():
	if modulate.a > 0.0:
		queue_free()

func set_lit(new_lit: bool):
	if new_lit != is_lit:
		if not new_lit:
			await get_tree().create_timer(.5)
		is_lit = new_lit
