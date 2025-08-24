extends SpotLight3D

var base_pos : Vector3;
var base_rot : Vector3;
var base_energy : float;

var min_pos : Vector3;
var max_pos : Vector3;

var min_rot : Vector3;
var max_rot : Vector3;

@export
var noise_offset: float = 0;

@export
var swing_speed = 10.0;
@export
var blink_speed = .02;
@export
var pos_offset: Vector3;
@export
var rot_offset: Vector3;
@export 
var min_energy:float;

func _ready():
	base_pos = get_global_position();
	base_rot = get_global_rotation();
	min_pos = base_pos - pos_offset;
	max_pos = base_pos + pos_offset;
	min_rot = base_rot - rot_offset;
	max_rot = base_rot + rot_offset
	base_energy = light_energy;

func _process(delta):
	var current_time : int = Time.get_ticks_msec();
	
	var lerp_pos = (sin(noise_offset + current_time * swing_speed / 100) + 1) / 2;
	var new_rot = lerp(min_rot, max_rot, lerp_pos);
	var new_pos = lerp(min_pos, max_pos, lerp_pos);
	
	var lerp_blink = (sin(noise_offset + current_time * blink_speed / 100) + 1) / 2;
	var new_light = lerp(min_energy, base_energy, lerp_blink);
	
	light_energy = new_light;
	set_global_position(new_pos);
	set_global_rotation(new_rot);
