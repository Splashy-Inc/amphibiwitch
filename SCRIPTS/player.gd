extends CharacterBody2D

class_name Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var net: Node2D = $Tools/Net
@onready var staff: Staff = $Tools/Staff
@onready var shoes: Sprite2D = $Shoes
@onready var skin_tone:Sprite2D = $SkinTone
@onready var hair: Sprite2D = $Hair
@onready var accessories: Sprite2D = $Accessories
@onready var equipment: Node2D = $Tools/Frog

const SPEED = 500.0
@export var speed_mod := 1.0

@export var attacking := false
var direction := Vector2.ZERO

var interaction_queue : Array[Node2D]

var grappling_target : Node2D

func _ready() -> void:
	AppearanceEvents.appearance_changed.connect(_on_appearance_changed)
	_on_appearance_changed(AppearanceEvents.get_current_appearance())
	if equipment is Frog:
		equipment.ability.target_hit.connect(_on_frog_target_hit)

func _physics_process(delta: float) -> void:
	if not grappling_target:
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
	else:
		if global_position.distance_to(grappling_target.global_position) > 64:
			global_position = global_position.lerp(grappling_target.global_position, 0.1)
		else:
			grappling_target = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("net") and attacking == false:
		if (OS.has_feature("web_android") or OS.has_feature("web_ios")) and event is InputEventMouse:
			return
		net.show()
		staff.show()
		equipment.hide()
		attacking = true
		_use_net()
	elif (event.is_action_pressed("interact") or event.is_action_pressed("light")) and not interaction_queue.is_empty():
		if interaction_queue.front().has_method("interact"):
			interaction_queue.front().interact()
	elif event.is_action_pressed("use_equipment"):
		if equipment is Frog:
			net.hide()
			staff.hide()
			equipment.show()
			equipment.use_ability()
			# TODO: Properly handle disabling other actions while frog ability being used

func _use_net():
	animation_player.play("attack")

func _on_interaction_range_body_entered(body: Node2D) -> void:
	if not body in interaction_queue:
		interaction_queue.append(body)

	if interaction_queue.front().has_method("show_control"):
		interaction_queue.front().show_control()

func _on_interaction_range_body_exited(body: Node2D) -> void:
	interaction_queue.erase(body)
	if body.has_method("hide_control"):
		body.hide_control()
	
	if not interaction_queue.is_empty() and interaction_queue.front().has_method("show_control"):
		interaction_queue.front().show_control()

func _on_appearance_changed(new_appearance_data: AppearanceData):
	if new_appearance_data:
		shoes.texture = new_appearance_data.get_shoes_sprite_sheet()
		skin_tone.texture = new_appearance_data.get_skin_sprite_sheet()
		hair.texture = new_appearance_data.get_hair_sprite_sheet()
		accessories.texture = new_appearance_data.get_accessory_sprite_sheet()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	EventBus.player_exited_screen.emit()

func _on_frog_target_hit(body: Node2D):
	if body.is_in_group("moveable") and body.has_method("on_hit"):
		body.on_hit()
	else:
		grappling_target = body
