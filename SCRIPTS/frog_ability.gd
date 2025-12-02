extends RigidBody2D

class_name FrogAbility

signal extended
signal retracted
signal anchor_hit(body: Node2D)
signal anchor_reached(body: Node2D)

@onready var tongue_body: Line2D = $TongueBody
@onready var tongue_tip: Sprite2D = $TongueTip
@onready var hitbox: Area2D = $Hitbox
@onready var cooldown_timer: Timer = $CooldownTimer

@export var ability_origin: Node2D
@export var max_distance := 256
@export var extend_speed := 2000
@export var retract_speed := 1000

enum State {
	NONE,
	EXTENDING,
	RETRACTING,
}

var state := State.NONE

var moveable : Node2D
var anchor : Node2D

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
	if ability_origin and not freeze:
		linear_velocity = global_position.direction_to(ability_origin.global_position) * retract_speed
	tongue_body.points[0] = to_local(ability_origin.global_position)
	
	if global_position.distance_to(ability_origin.global_position) < 30:
		if is_instance_valid(moveable):
			if moveable.has_method("on_hit"):
				moveable.on_hit()
				moveable = null
			else:
				EventBus.release_to_level.emit(moveable)
		elif anchor:
			anchor_reached.emit(anchor)
		
		retracted.emit()
		deactivate()

func activate():
	if is_usable():
		cooldown_timer.start()
		global_position = ability_origin.global_position
		freeze = false
		extend()

func deactivate():
	freeze = true
	reparent(ability_origin)
	tongue_body.points[0] = Vector2.ZERO
	global_position = ability_origin.global_position
	linear_velocity = Vector2.ZERO
	state = State.NONE

func extend():
	linear_velocity = Vector2.ZERO
	apply_impulse(Vector2.UP.rotated(ability_origin.global_rotation) * extend_speed)
	state = State.EXTENDING
	extended.emit()

func retract():
	linear_velocity = Vector2.ZERO
	state = State.RETRACTING

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("moveable"):
		body.global_position = global_position
		body.reparent(self)
		moveable = body
	else:
		linear_velocity = Vector2.ZERO
		set_deferred("freeze", true)
		anchor = body
		anchor_hit.emit(body)
	retract()

func toggle_enabled(is_enabled: bool):
	if is_enabled:
		show()
	else:
		hide()
	hitbox.monitoring = is_enabled
	hitbox.monitorable = is_enabled

func is_usable() -> bool:
	return cooldown_timer.is_stopped()

func _on_cooldown_timer_timeout() -> void:
	if get_parent() != ability_origin:
		anchor = null
		freeze = false
		retract()
