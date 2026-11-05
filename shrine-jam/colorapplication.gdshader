shader_type canvas_item;
uniform sampler2D screenTexture : hint_screen_texture, filter_linear_mipmap;
uniform vec4 darkColor: source_color = vec4(0,0,0,1);
uniform vec4 lightColor: source_color = vec4(1,1,1,1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 underColor = texture(screenTexture, SCREEN_UV);
	
	if (underColor == vec4(0,0,0,1) ){
		COLOR = darkColor;
	}
	else if (underColor == vec4(1,1,1,1)){
		COLOR = lightColor;
	}
	else{
		COLOR = underColor;
	}
		
}