extends Node

class_name Level

signal won

@export var dialog_box: DialogBox
@export var mobile_controls: MobileControls

func _ready() -> void:
	if dialog_box:
		dialog_box.dialog_ended.connect(_on_dialog_ended.bind(dialog_box))
	if mobile_controls:
		if OS.has_feature("web_android") or OS.has_feature("web_ios") or OS.has_feature("mobile"):
			mobile_controls.show()
		else:
			mobile_controls.hide()
	_level_ready()

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
