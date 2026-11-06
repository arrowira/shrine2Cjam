shader_type canvas_item;
uniform sampler2D screenTexture : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float sx = float(int(SCREEN_UV.x)%2);
	float sy = float(int(SCREEN_UV.y)%2);
	vec4 underColor = texture(screenTexture,vec2(sx, sy));
	vec2 uv = UV;
	COLOR = underColor;
	// Called for every pixel the material is visible on.
}
