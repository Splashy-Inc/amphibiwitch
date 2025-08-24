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

func set_attribute_data(new_attribute_data: AttributeData):
	attribute_data = new_attribute_data
	set_texture(attribute_data.sprite_sheet)
	match attribute_data.category:
		AttributeData.Category.SHOES:
			sprite.hframes = 8
		AttributeData.Category.SKINTONE:
			sprite.hframes = 1
		AttributeData.Category.HAIR:
			sprite.hframes = 4
		AttributeData.Category.ACCESSORY:
			sprite.hframes = 4
			sprite.vframes = 2

func _on_pressed() -> void:
	AppearanceEvents.attribute_change_requested.emit(attribute_data)
