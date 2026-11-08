shader_type canvas_item;

uniform float radius = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float d = pow(pow(UV.x-0.5,2) + pow(UV.y-0.5,2), 0.5);
	if (d<radius){
		COLOR = vec4(0,0,0,0);
	}
	else{
		COLOR = vec4(1,0,0,1);
	}
		
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
