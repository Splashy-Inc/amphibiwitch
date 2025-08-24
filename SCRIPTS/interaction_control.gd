extends PanelContainer

@onready var control_label: Label = $HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.is_mobile:
		control_label.text = "STAFF"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
