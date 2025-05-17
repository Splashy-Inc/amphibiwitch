extends Level

func _level_ready():
	await get_tree().create_timer(1).timeout
	Globals.update_info("Updated")
