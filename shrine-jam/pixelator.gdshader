shader_type canvas_item;
uniform sampler2D screenTexture : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float pixelation = 0.0015;
	float px = pixelation*1.5;
	float py = pixelation*0.4;
	float sx = float(int(SCREEN_UV.x / px))*px;
	float sy = float(int(SCREEN_UV.y / py))*py;
	vec4 underColor = texture(screenTexture,vec2(sx, sy));
	vec2 uv = UV;
	COLOR = underColor;
	// Called for every pixel the material is visible on.
}
