shader_type canvas_item;

uniform float thresh = 2.0;
const float c = 50.0;

void fragment() {
	float uy = UV.y*c - (c-1.0);
	float d = pow(pow(UV.x-0.5,2) + pow(uy-0.5,2), 0.5);
	if (d>0.5 && uy > 0.5){
		COLOR = vec4(0,0,0,1);
	}
		
	if ((UV.y + UV.x/10.0) > thresh){
		COLOR.a = 0.0;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
