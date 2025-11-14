shader_type canvas_item;

uniform sampler2D noise : repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

float rand(float x){
	return fract(sin(x*1249.53)*12058.21);
}

void fragment() {
	vec2 uv = UV;
	uv = floor(uv * 128.)/128.;

	vec2 puv = UV;
	puv = floor(puv * 32.)/32.;
	float t = floor(TIME*2.)/2.;
	//uv.y += (rand(puv.y+puv.x+t)-.5)*.1;
	//uv.x += (rand(puv.y+puv.x-t*124.27)-.5)*.1;

	uv.x += tan(uv.y*10.+((rand(puv.y+t)-.5)*10.)+sin(uv.x*1.+TIME)*.1+TIME*2.)*.01;

	vec4 col = textureLod(TEXTURE, UV, 0.);
	vec3 c = textureLod(TEXTURE, uv, 0.).rgb;
	vec4 behind = textureLod(TEXTURE, uv, 0.);
	behind.rgb = round(vec3(rand(uv.x),rand(uv.y),rand(uv.y)));
	col.rgb = c.rgb * col.a + behind.rgb * (1. - col.a);
	if (textureLod(noise, uv, 0.).x > sin(TIME*.5+uv.y*5.)*.2+.5)
		col.rgb = (vec3(round(rand(uv.x)),round(rand(uv.y)),round(rand(uv.y))));
	col.a = max(col.a, behind.a);
	COLOR = col;

	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
