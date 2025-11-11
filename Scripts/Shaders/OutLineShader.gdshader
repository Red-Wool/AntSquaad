shader_type canvas_item;

uniform vec3 outlineColor = vec3(.17,.03,.33);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 tps = TEXTURE_PIXEL_SIZE*2.;
	vec2 uv = UV;
	uv = floor(uv / tps) * tps;
	float pct = 0.;
	
	for (int x = -1; x < 4; x++){
		for (int y = -1; y < 4; y++){
			pct = max(pct, textureLod(TEXTURE, uv+vec2(float(x),float(y))*tps*.5,0.).a);
		}
	}
	
	vec4 col = textureLod(TEXTURE, UV, 0.);
	col.rgb = col.rgb * (col.a) + outlineColor * (1. - col.a);
	col.a = pct;
	
	COLOR = col;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
