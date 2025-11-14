shader_type canvas_item;

uniform sampler2D perlin : repeat_enable;
uniform bool powered;

uniform vec3 unpoweredArrowColor = vec3(.2,.41,.86);
uniform vec3 poweredArrowHeadColor = vec3(1.,.31,.41);
uniform vec3 poweredArrowTailColor = vec3(.29,.91,.89);

void vertex() {

	//VERTEX += sin(VERTEX.x+VERTEX.y+TIME*1000.)*1.;
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec2 uv = UV;
	uv = floor(5.*uv)/5.;
	if (!powered){
		vec3 col = vec3(textureLod(perlin, uv*.1-(vec2(1,0))*TIME*.1, 0.).x*.3);
		float x = fract(uv.x*.1);
		x += sin(TIME*2.)*.05;
		float y = abs(uv.y-.5)*.2;
		y = step(.4,x+y) - step(.6, x+y);
		
		col += unpoweredArrowColor * y;
		
		col = floor(3.*col)/2.;
		
		COLOR = vec4(col,1.);
	}
	else{
		uv.x += abs(uv.y-.5)*5.;
		uv.x = fract(uv.x*.1-TIME*1.5) + textureLod(perlin, uv*.1-TIME*.3, 0.).x*.5;
		//uv.x -= abs(uv.y-.5)*1.;
		COLOR = vec4(mix(poweredArrowTailColor,poweredArrowHeadColor,floor(3.*uv.x)/2.),1.);
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
