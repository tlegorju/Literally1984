extends Node3D

@export var offset: Vector3;
@export var anim_length: float = 1;

var base_pos:Vector3;

var current_duration: float;
var current_origin: Vector3;
var current_target: Vector3;

func _ready() -> void:
	base_pos = get_global_position();

func on_collision_entered(body):
	print("entered !!");
	current_origin = base_pos;
	current_target = base_pos + offset;
	current_duration = 0;
	
func on_collision_exited(body):
	print("exited !!");
	current_target = base_pos;
	current_origin = base_pos + offset;
	current_duration = 0;
	
func _process(delta: float) -> void:
	if(current_duration >= anim_length):
		return;
		
	current_duration += delta;
	var weight = smoothstep(0, 1, current_duration / anim_length);
	set_global_position(lerp(current_origin, current_target, weight));
