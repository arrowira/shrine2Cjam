shader_type canvas_item;

uniform float radius = 0.1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float t = TIME;
	float dotSize = 1.0;
	float ux = UV.x + cos(t+UV.x*20.0)/500.0;
	float uy = UV.y + sin(t+UV.y*20.0)/500.0;
	int dotMod = 5;
	float d = pow(pow(UV.x-0.5,2) + pow(UV.y-0.5,2), 0.5);
	if (d<radius){
		COLOR = vec4(0,0,0,0);
	}
	else{
		int qx = int((ux * 1000.0)/dotSize);
		int qy = int((uy * 1000.0)/dotSize);
		
		if (qx % dotMod == 0 && qy % dotMod == 0){
			COLOR = vec4(1,1,1,1);
		}
		else{
			COLOR = vec4(0,0,0,1);
		}
	}
	float angle = atan(UV.y,UV.x);
	float margin = sin((UV.x + t/80.0)*200.0)/800.0 + sin((UV.y + t/60.0)*200.0)/800.0;
	if (d>radius+(margin-0.003) && d<radius+margin-0.001){
		COLOR = vec4(1,1,1,1);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
