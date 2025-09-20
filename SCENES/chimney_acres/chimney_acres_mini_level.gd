extends Level

@onready var boundary: TileMapLayer = $GameTileMap/Boundary

func _level_ready() -> void:
	boundary.visible = false
