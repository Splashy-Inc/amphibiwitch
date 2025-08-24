extends StaticBody2D

@export var destination_screen : PackedScene
@onready var interaction_control: PanelContainer = $InteractionControl

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_control()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_control():
	interaction_control.show()

func hide_control():
	interaction_control.hide()

func interact():
	if destination_screen:
		EventBus.screen_requested.emit(destination_screen)
