extends Button

class_name AttributeButton

@export var attribute_data : AttributeData

@onready var sprite: Sprite2D = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if attribute_data:
		set_texture(attribute_data.sprite_sheet)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_texture(new_texture: Texture2D):
	sprite.texture = new_texture
