extends CharacterBody2D

class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var net: Node2D = $Tool/Net
@onready var staff: Staff = $Tool/Staff

const SPEED = 500.0
@export var speed_mod := 1.0

@export var attacking := false
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	staff.active = Input.is_action_pressed("light")
	
	if not attacking:
		var new_direction = Vector2.ZERO
		if Globals.is_mobile and Globals.joystick:
			new_direction = Globals.joystick.direction
		else:
			new_direction = Input.get_vector("left", "right", "up", "down") + Input.get_vector("stick_left", "stick_right", "stick_up", "stick_down")
		
		if new_direction and new_direction != Vector2.ZERO:
			speed_mod = 1.0
			if Globals.is_mobile:
				direction = new_direction.normalized()
			else:
				direction = direction.lerp(new_direction.normalized(), .1)
			animation_player.play("move")
		else:
			speed_mod = 0.0
			animation_player.play("idle")
		
		rotation = -direction.angle_to(Vector2.UP)
		#rotation = -global_position.direction_to(get_global_mouse_position()).angle_to(Vector2.UP)
	velocity = direction * SPEED * speed_mod
		
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("net") and attacking == false:
		if (OS.has_feature("web_android") or OS.has_feature("web_ios")) and event is InputEventMouse:
			return
		attacking = true
		_use_net()

func _use_net():
	animation_player.play("attack")
