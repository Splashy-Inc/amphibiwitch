extends RigidBody2D

class_name FrogAbility

signal target_hit(body: Node2D)

@onready var tongue_body: Line2D = $TongueBody
@onready var tongue_tip: Sprite2D = $TongueTip

@export var ability_origin: Node2D
@export var max_distance := 256
@export var speed := 1000

enum State {
	NONE,
	EXTENDING,
	RETRACTING,
}

var state := State.NONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		State.NONE:
			idle_state(delta)
		State.EXTENDING:
			extending_state(delta)
		State.RETRACTING:
			retracting_state(delta)

func idle_state(delta: float):
	pass

func extending_state(delta: float):
	if ability_origin:
		tongue_body.points[0] = to_local(ability_origin.global_position)
		if global_position.distance_to(ability_origin.global_position) > max_distance:
			retract()

func retracting_state(delta: float):
	if ability_origin:
		if global_position.distance_to(ability_origin.global_position) > max_distance:
			linear_velocity = Vector2.ZERO
			apply_impulse(global_position.direction_to(ability_origin.global_position) * speed)
		else:
			apply_force(global_position.direction_to(ability_origin.global_position) * speed)
		tongue_body.points[0] = to_local(ability_origin.global_position)
		if global_position.distance_to(ability_origin.global_position) < 10:
			deactivate()

func activate():
	if state == State.NONE:
		global_position = ability_origin.global_position
		freeze = false
		extend()

func deactivate():
	freeze = true
	reparent(ability_origin)
	global_position = ability_origin.global_position
	linear_velocity = Vector2.ZERO
	state = State.NONE

func extend():
	linear_velocity = Vector2.ZERO
	apply_impulse(Vector2.UP.rotated(ability_origin.global_rotation) * speed)
	state = State.EXTENDING

func retract():
	linear_velocity = Vector2.ZERO
	state = State.RETRACTING

func _on_hitbox_body_entered(body: Node2D) -> void:
	#target_hit.emit(body)
	retract()
