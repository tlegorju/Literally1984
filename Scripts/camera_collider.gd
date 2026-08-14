extends Area3D

@onready var work_camera: Camera3D = $WorkCamera
@export var is_player_inside = false;

func _on_body_entered(body: Node3D):
	if not body.is_in_group("Player"):
		return
	print("Camera : " + get_parent().name + " player inside : " + str(is_player_inside) + "\nbody entered : " + body.name)
	if(is_player_inside): return;
	work_camera.current = true;
	is_player_inside = true;
	
func _on_body_exited(body):
	is_player_inside = false;
