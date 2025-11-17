shader_type canvas_item;

varying vec2 world_pos;

void vertex() {
	world_pos = VERTEX;

	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = world_pos * .001;
	vec2 fuv = fract(uv);
	vec4 col;

	col.rgb = vec3(1,1,0)*(1.-col.a);

	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
