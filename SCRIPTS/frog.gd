extends CharacterBody2D

class_name Frog

const SPEED = 200.0


func _physics_process(delta: float) -> void:
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func on_hit():
	queue_free()
