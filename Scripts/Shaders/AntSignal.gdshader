shader_type canvas_item;
//render_mode world_vertex_coords;

varying vec2 world_position;

void vertex() {
	world_position = VERTEX;
	
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 suv = world_position;
	
	vec2 ruv = UV;
	ruv -= .5;
	//ruv.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	
	
	
	suv = floor(suv*1.)/1.;
	//suv += normalize(ruv)*TIME;
	suv += (floor(TIME*12.)/12.)*2.;
	suv = fract(suv*.2);
	suv -= .5;
	
	float pct = (1.-smoothstep(.2,.5,abs(suv.x))) * (1.-smoothstep(.2,.5,abs(suv.y)));
	
	COLOR = vec4(vec3(.2,.2,1.)*pct,textureLod(TEXTURE,UV,0.).a*pow(pct,2.));
	COLOR.a += pct * (sin(length(ruv)*20.-TIME*10.)*.5+.5) * (1.-smoothstep(.4, .5,length(ruv)));
	//COLOR.rgb = vec3(length(ruv));
	//COLOR.a = 1.;
	// Called for every pixel the material is visible on. //textureLod(TEXTURE,UV,0.).a
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
