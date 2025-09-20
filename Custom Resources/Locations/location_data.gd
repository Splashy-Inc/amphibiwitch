extends Resource

class_name LocationData

enum Name {
	NONE,
	START,
	SHOP,
	CHIMNEY_ACRES,
}

@export var name : LocationData.Name
@export var scene : PackedScene
