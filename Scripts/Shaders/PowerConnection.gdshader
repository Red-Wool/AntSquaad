shader_type canvas_item;

uniform sampler2D perlin : repeat_enable;
uniform bool powered;

void vertex() {

	//VERTEX += sin(VERTEX.x+VERTEX.y+TIME*1000.)*1.;
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec2 uv = UV;
	uv = floor(5.*uv)/5.;
	if (!powered){
		vec3 col = vec3(textureLod(perlin, uv*.1-(vec2(1,0))*TIME*.1, 0.).x*.3);
		col = floor(8.*col)/8.;
		COLOR = vec4(col,1.);
	}
	else{
		uv.x = fract(uv.x*.1-TIME) + textureLod(perlin, uv*.1-TIME*.3, 0.).x*.5;
		COLOR = vec4(mix(vec3(.2,.2,1.),vec3(1.,.2,.2),floor(8.*uv.x)/8.),1.);
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
