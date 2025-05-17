extends CharacterBody2D

class_name Player

@onready var net_attack_area: Area2D = $NetAttackArea
@onready var net_collider: CollisionShape2D = $NetAttackArea/CollisionShape2D
@onready var attack_time: Timer = $NetAttackArea/AttackTime
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var net: Node2D = $Tool/Net
@onready var staff: Staff = $Tool/Staff

const SPEED = 300.0

var attacking := false
var direction := Vector2.ZERO

func _ready() -> void:
	net_attack_area.hide()

func _physics_process(delta: float) -> void:
	if not attacking:
		staff.active = Input.is_action_pressed("light")
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		direction = direction.lerp(Input.get_vector("left", "right", "up", "down").normalized(), .1)
		if direction:
			animation_player.play("move")
			rotation = -direction.angle_to(Vector2.UP)
		else:
			animation_player.play("idle")
		
		velocity = direction * SPEED
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
