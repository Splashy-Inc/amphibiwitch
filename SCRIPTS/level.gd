extends Node

class_name Level

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
	if mobile_controls.visible and dialog_box.visible:
		mobile_controls.hide()

func _physics_process(delta: float) -> void:
	pass

func _on_dialog_ended(dialog_box: DialogBox):
	print_debug("Dialog ended: ", dialog_box)
