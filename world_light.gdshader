shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 world_light_color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	COLOR = mix(screen_color, world_light_color, .9);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
