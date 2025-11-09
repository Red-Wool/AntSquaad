shader_type canvas_item;

uniform float pixelSize = .5;
uniform sampler2D screen : hint_screen_texture, filter_nearest_mipmap;

varying vec2 localPos;
varying vec2 worldPos;

varying mat4 canvas;

void vertex() {
	localPos = VERTEX;
	worldPos = ((MODEL_MATRIX) * vec4(VERTEX, 0, 1)).xy;;
	canvas = CANVAS_MATRIX;
	//pos = ((MODEL_MATRIX * CANVAS_MATRIX * SCREEN_MATRIX) * vec4(VERTEX, 0, 1)).xy;
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec2 uv = worldPos;
	vec2 luv = localPos - fract(worldPos*pixelSize);
	uv = floor(uv * pixelSize) / pixelSize;
	luv = floor(luv * pixelSize) / pixelSize;

	vec2 suv = ((canvas) * vec4(uv, 0, 1)).xy;
	COLOR = textureLod(screen, suv * SCREEN_PIXEL_SIZE, 0.);
	
	float pct = sin(length(luv)*.1-TIME*4.)*.5+.5;
	COLOR.rgb = vec3(1.,.2,.2)*pct + vec3(.2,.2,1.)*(1.-pct);
	COLOR.rgb = floor(COLOR.rgb*4.)/4.;
	COLOR.a = floor(COLOR.a);

	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
