extends Area3D

@onready var work_camera: Camera3D = $WorkCamera
var is_player_inside = false;

func _on_body_entered(body):
	if(is_player_inside): return;
	work_camera.current = true;
	is_player_inside = true;
	
func _on_body_exited(body):
	is_player_inside = false;
