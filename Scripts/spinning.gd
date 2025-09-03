extends Node3D

@export var turn_speed = 1.0;
@export var turn_length = 4.0;
@export var rotation_direction = Vector3(0, 1, 0);
@export var min_intensity: float = 4.
@export var blink_speed: float = .5;

@onready var spotlight1: SpotLight3D = $SpotLight3D
@onready var spotlight2: SpotLight3D = $SpotLight3D2
@onready var siren: AudioStreamPlayer3D = $siren

var current_duration = 99999.;
var base_intensity1;
var base_intensity2;


func _ready() -> void:
	base_intensity1 = spotlight1.light_energy;
	base_intensity2 = spotlight2.light_energy;
	spotlight1.light_energy = 0;
	spotlight2.light_energy = 0;
	GameManager.gyro_start.connect(play_alert);

func _process(delta):
	if(current_duration <= turn_length):
		rotate(rotation_direction, deg_to_rad(turn_speed) * delta);
	else:
		siren.playing = false;
		
	if(current_duration <= turn_length || spotlight1.light_energy > 0.01):
		current_duration += delta;
		var blink_weight = (sin(blink_speed * current_duration) + 1) / 2;
		var smoothed_weight = smoothstep(0, 1, blink_weight);
		spotlight1.light_energy = lerp(min_intensity, base_intensity1, smoothed_weight);
		spotlight2.light_energy = lerp(min_intensity, base_intensity2, smoothed_weight);
	
func play_alert():
	siren.playing = true;
	current_duration = 0;
