extends CharacterBody2D

class_name Player

@onready var net_attack_area: Area2D = $NetAttackArea
@onready var net_collider: CollisionShape2D = $NetAttackArea/CollisionShape2D
@onready var attack_time: Timer = $NetAttackArea/AttackTime

const SPEED = 300.0

var attacking := false

func _ready() -> void:
	net_attack_area.hide()

func _physics_process(delta: float) -> void:
	if not attacking:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_vector("left", "right", "up", "down").normalized()
		velocity = direction * SPEED
		if direction:
			rotation = -direction.angle_to(Vector2.UP)

		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("net") and attacking == false:
		_use_net()

func _use_net():
	net_attack_area.show()
	net_collider.disabled = false
	attack_time.start()
	attacking = true

func _on_attack_time_timeout() -> void:
	net_attack_area.hide()
	net_collider.disabled = true
	attacking = false

func _on_net_attack_area_body_entered(body: Node2D) -> void:
	if body is Frog:
		body.on_hit()
