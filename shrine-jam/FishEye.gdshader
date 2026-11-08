shader_type canvas_item;
uniform sampler2D screenTexture : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float d = pow(pow(UV.x-0.5,2) + pow(UV.y-0.5,2), 0.5);
	float dFactor = (d)/(d+0.005);
	float sx = SCREEN_UV.x * dFactor;
	float sy = SCREEN_UV.y * dFactor;
	vec4 underColor = texture(screenTexture,vec2(sx, sy));
	
	COLOR = underColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
