extends Level

@onready var world_light: DirectionalLight2D = $WorldLight

func _level_ready():
	world_light.energy = .1
	await get_tree().create_timer(1).timeout
	Globals.update_info("Updated")
