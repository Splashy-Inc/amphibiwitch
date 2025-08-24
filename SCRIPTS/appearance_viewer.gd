extends PanelContainer

@export var appearance_data : AppearanceData

@onready var shoes: Sprite2D = $Character/Shoes
@onready var skin: Sprite2D = $Character/Skin
@onready var hair: Sprite2D = $Character/Hair
@onready var accessory: Sprite2D = $Character/Accessory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_appearance(appearance_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_appearance(new_appearance_data: AppearanceData):
	appearance_data = new_appearance_data
	
	if appearance_data.shoes:
		shoes.texture = appearance_data.shoes.sprite_sheet
	if appearance_data.skin:
		skin.texture = appearance_data.skin.sprite_sheet
	if appearance_data.hair:
		hair.texture = appearance_data.hair.sprite_sheet
	if appearance_data.accessory:
		accessory.texture = appearance_data.accessory.sprite_sheet
