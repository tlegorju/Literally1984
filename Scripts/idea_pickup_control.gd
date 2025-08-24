extends Node3D

var start : Vector3
var wordPair

func _ready() -> void:
	start = $StaticBody3D/MeshInstance3D.get_position()

func _process(delta: float) -> void:
	$StaticBody3D/MeshInstance3D.set_position(start + Vector3(0,sin(Time.get_ticks_usec()/100000)*0.05,0))

func SetWordPair(pair):
	wordPair=pair
	
func GetWordPair():
	return wordPair
