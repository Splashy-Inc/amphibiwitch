shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;
uniform float modulate = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	vec4 texture_color = texture(TEXTURE, UV);
	if(texture_color.a > 0.0){
		COLOR = screen_color * texture_color;
		COLOR.a *= modulate;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
