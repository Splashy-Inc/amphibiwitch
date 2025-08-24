extends Button

@export var attribute_data : AttributeData

@onready var attribute_texture: TextureRect = $Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if attribute_data:
		set_texture(attribute_data.texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_texture(new_texture: Texture2D):
	attribute_texture.texture = new_texture
