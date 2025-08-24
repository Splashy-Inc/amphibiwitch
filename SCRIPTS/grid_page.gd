extends PanelContainer

@export var attribute_list : AttributeList
@export var attribute_button_scene : PackedScene
@onready var grid_container: GridContainer = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for attribute in attribute_list.list:
		add_attribute(attribute)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_attribute(attribute_data: AttributeData):
	var new_button = attribute_button_scene.instantiate() as AttributeButton
	grid_container.add_child(new_button)
	if not new_button.is_node_ready():
		await new_button.ready
	new_button.set_texture(attribute_data.sprite_sheet)
	
