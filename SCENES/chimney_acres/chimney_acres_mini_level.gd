extends Node2D

@onready var boundary: TileMapLayer = $GameTileMap/Boundary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boundary.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
