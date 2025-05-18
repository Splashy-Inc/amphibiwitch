extends Level

@onready var world_light: DirectionalLight2D = $WorldLight

func _level_ready():
	await get_tree().create_timer(1).timeout
	Globals.update_info("Updated")
