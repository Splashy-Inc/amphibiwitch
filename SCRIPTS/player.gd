extends CharacterBody2D

class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var net: Node2D = $Tool/Net
@onready var staff: Staff = $Tool/Staff

const SPEED = 500.0

@export var attacking := false
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	staff.active = Input.is_action_pressed("light") and not attacking
	
	if not attacking:
		if Globals.is_mobile and Globals.joystick:
			direction = Globals.joystick.direction
		else:
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
		if (OS.has_feature("web_android") or OS.has_feature("web_ios")) and event is InputEventMouse:
			return
		attacking = true
		_use_net()

func _use_net():
	animation_player.play("attack")
