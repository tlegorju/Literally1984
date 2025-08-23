extends Node3D

var isLocked = true

func interact():
	if isLocked:
		print("can't open")
	else:
		get_tree().change_scene_to_file("res://Scenes/inception_scene.tscn")
		
func unlock():
	isLocked=false
