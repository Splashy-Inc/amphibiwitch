extends Node

class_name Level

signal won

@onready var frogs_container: Node = $Frogs

@export var location_name : LocationData.Name

@export var dialog_box: DialogBox
@export var mobile_controls: MobileControls

@export var player_container: Node
@export var camera : Camera2D

func _ready() -> void:
	if dialog_box:
		dialog_box.dialog_ended.connect(_on_dialog_ended.bind(dialog_box))
	if mobile_controls:
		if OS.has_feature("web_android") or OS.has_feature("web_ios") or OS.has_feature("mobile"):
			mobile_controls.show()
		else:
			mobile_controls.hide()
	
	spawn_player()
	_level_ready()
	
	EventBus.frog_ability_used.connect(_on_frog_ability_used)
	EventBus.release_to_level.connect(_on_node_released_to_level)

func _level_ready():
	pass

func _process(delta: float) -> void:
	# Ensure that the mobile controls are not visible if the dialog box is present
	if dialog_box:
		if mobile_controls.visible and dialog_box.visible:
			mobile_controls.hide()
	
	_level_process(delta)
	
func _level_process(delta: float):
	pass

func _physics_process(delta: float) -> void:
	pass

func initialize(origin_name: LocationData.Name = LocationData.Name.NONE):
	spawn_player(origin_name)

func _on_dialog_ended(dialog_box: DialogBox):
	print_debug("Dialog ended: ", dialog_box)

func pause_play():
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
	if dialog_box:
		dialog_box.process_mode = ProcessMode.PROCESS_MODE_DISABLED
	
func resume_play(new_mouse_mode: int = Input.MOUSE_MODE_VISIBLE):
	process_mode = ProcessMode.PROCESS_MODE_INHERIT
	if dialog_box:
		dialog_box.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
		dialog_box.update_view()

func spawn_player(origin_name: LocationData.Name = LocationData.Name.NONE):
	for player in get_tree().get_nodes_in_group("Player"):
		player.queue_free()
	
	var new_player = Globals.generate_player() as Player
	player_container.add_child(new_player)
	
	camera.reparent(new_player)
	
	if origin_name != LocationData.Name.NONE:
		for location_transition in get_tree().get_nodes_in_group("location_transition_area"):
			if location_transition is LocationTransitionArea:
				if location_transition.destination_name == origin_name:
					new_player.global_position = location_transition.global_position

func _on_frog_ability_used(ability: FrogAbility):
	ability.reparent(player_container)
	ability.activate()

func _on_node_released_to_level(node: Node2D):
	if node is Frog:
		node.reparent(frogs_container)
	node.reparent(self)
