shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 original_col = texture(TEXTURE, UV);
	COLOR = mix(vec4(0.0), original_col, sqrt(UV.y));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
