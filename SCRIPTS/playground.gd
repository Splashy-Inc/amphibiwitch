extends Level

@onready var world_light: DirectionalLight2D = $WorldLight

func _level_ready():
	Globals.goal_frogs = get_tree().get_node_count_in_group("Frog")/2
	Globals.update_info(0)
	Globals.info_updated.connect(_on_info_updated)
	
func _on_info_updated(info):
	if Globals.info >= Globals.goal_frogs:
		won.emit()
