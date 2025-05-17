extends Node

signal info_updated

var cur_level_scene: PackedScene

var joypad_connected := false

var joystick: JoyStick

var info = 10 # Example info to track for level UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	joypad_connected = Input.get_connected_joypads().size() > 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_joy_connection_changed(device, connected):
	joypad_connected = Input.get_connected_joypads().size() > 0

func update_info(new_info):
	info = new_info
	info_updated.emit(info)
