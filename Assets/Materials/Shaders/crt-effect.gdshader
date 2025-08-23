shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise_texture : filter_linear_mipmap, repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dispersion = .005;
	float distortion = .006;
	float noisestrength = .025;
	float bendscale = 1.5;
	float stripes_mult = .15;

	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE);
	vec4 screen_col = texture(screen_texture, uv);

	uv.x = 1.0 - uv.x;
	vec2 disp = uv - vec2(.5, .5);
	disp *= sqrt(length(disp));
	uv += disp * bendscale;
	uv = (uv + .5)/2.0;
	vec2 uvr = uv * (1.0 - dispersion) + vec2(dispersion, dispersion)/2.0;
	vec2 uvg = uv * 1.0;
	vec2 uvb = uv * (1.0 + dispersion) - vec2(dispersion, dispersion)/2.0;

	vec3 offset = texture(noise_texture, vec2(0, uv.y + TIME * 255.0)).xyz;

	float r = mix(texture(screen_texture, vec2(1.0 - uvr.x, uvr.y) + offset.x * distortion).xyz,
				   offset, noisestrength).x;
	float g = mix(texture(screen_texture, vec2(1.0 - uvg.x, uvg.y) + offset.x * distortion).xyz,
				   offset, noisestrength).y;
	float b = mix(texture(screen_texture, vec2(1.0 - uvb.x, uvb.y) + offset.x * distortion).xyz,
				   offset, noisestrength).z;

	vec4 finalCol;

	if (uv.x > 0.0 && uv.x < 1.0 && uv.y > 0.0 && uv.y < 1.0) {
		float stripes = sin(uv.y * 300.0 + TIME * 10.0);
		vec3 col = vec3(r, g, b);
		col = mix(col, vec3(.8), stripes / 20.0 * stripes_mult);
		finalCol = vec4(col, 1.0);
	} else {
		finalCol = vec4(0, 0, 0, 1);
	}

	COLOR =  finalCol;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
