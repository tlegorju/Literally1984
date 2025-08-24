shader_type spatial;

const float max_energy = 4000.0;
const float blink_speed = 100.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float lerp_weight = (sin(TIME * blink_speed) + 1.) / 2.;
	vec3 max_albedo = vec3(max_energy, max_energy, max_energy);
	vec3 min_albedo = vec3(0, 0, 0);
	ALBEDO = mix(min_albedo, max_albedo, lerp_weight);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
