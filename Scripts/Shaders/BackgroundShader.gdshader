shader_type canvas_item;

varying vec2 world_pos;

void vertex() {
	world_pos = VERTEX;

	// Called for every vertex the material is visible on.
}

float grid(vec2 uv, float size, float time){
	uv *= size;
	uv += TIME * time;
	uv.x += tan(uv.y*1.+TIME*.2+sin(uv.x+TIME*time)*2.)*.01;
	uv = fract(uv);
	
	return min(step(uv.x,.1) + step(uv.y,.1), 1.);
}

void fragment() {
	vec2 uv = world_pos;
	uv = floor((uv) * 8.) / 8.;
	uv.x += tan(uv.y*1.1+TIME*1.)*.01;
	
	
	uv *= .01;
	vec4 col;
	float pct1 = grid(uv, 8., .11);
	float pct2 = grid(uv, 16., .051);
	float pct3 = grid(uv, 32., .0251);
	float pct4 = grid(uv, 64., .01251);
	
	col.a = min(pct1+pct2-pct3+pct4,1.);
	col.rgb = vec3(.17,.06,.33)*(1.-col.a) + vec3(.17,.06,.33)*.1 * col.a;
	col.a = 1.;
	
	COLOR = col;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
