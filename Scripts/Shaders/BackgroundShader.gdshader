shader_type canvas_item;

varying vec2 world_pos;

void vertex() {
	world_pos = VERTEX;

	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = world_pos * .01;
	vec2 fuv = fract(uv);
	vec4 col;
	float pct = step(fuv.x,.1) + step(fuv.y,.1);
	
	col.a = pct;
	col.rgb = vec3(1,1,0)*(1.-col.a) + col.rgb * col.a;
	col.a = 1.;
	
	COLOR = col;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
