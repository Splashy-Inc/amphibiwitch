extends Control

signal button_pressed

@onready var play_button: Button = $MenuContent/MenuButtons/PlayButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	button_pressed.emit("Play")

func _on_controls_button_pressed():
	button_pressed.emit("Controls")

func _on_quit_button_pressed():
	button_pressed.emit("Quit")

func _on_level_select_button_pressed():
	button_pressed.emit("Level")

func _on_play_button_visibility_changed() -> void:
	if visible:
		if not is_node_ready():
			await ready
		play_button.grab_focus()
