extends Node

signal info_updated

var cur_level_scene: PackedScene

var joypad_connected := false

var joystick: JoyStick

var info = 0 # Example info to track for level UI
var goal_frogs = 0

var is_mobile = false

const SOUNDS = [
	preload("res://ASSETS/Audio/background_theme.mp3"),
	preload("res://ASSETS/Audio/frog_hit.ogg"),
	preload("res://ASSETS/Audio/frog_idle.ogg"),
	preload("res://ASSETS/Audio/net_swing.ogg"),
	preload("res://ASSETS/Audio/staff_active.ogg"),
	preload("res://ASSETS/Audio/step_1.ogg"),
	preload("res://ASSETS/Audio/step_2.ogg"),
	preload("res://ASSETS/Audio/step_3.ogg"),
	preload("res://ASSETS/Audio/step_4.ogg"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	joypad_connected = Input.get_connected_joypads().size() > 0
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		is_mobile = true
	
	if is_mobile:
		for sound in SOUNDS:
			AudioServer.register_stream_as_sample(sound)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_joy_connection_changed(device, connected):
	joypad_connected = Input.get_connected_joypads().size() > 0

func update_info(new_info):
	info = new_info
	info_updated.emit(str(info) + "/" + str(goal_frogs))

func _on_frog_died():
	update_info(info + 1)
