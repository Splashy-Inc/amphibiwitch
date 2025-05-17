extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * SPEED
	if direction:
		rotation = -direction.angle_to(Vector2.UP)

	move_and_slide()
