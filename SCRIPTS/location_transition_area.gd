extends Area2D

class_name LocationTransitionArea

@export var destination_name : LocationData.Name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.player_exited_screen.connect(_on_player_exited_screen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition():
	EventBus.screen_requested.emit(destination_name)

func _on_player_exited_screen():
	for body in get_overlapping_bodies():
		if body is Player:
			transition()
