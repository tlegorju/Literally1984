extends Node3D

var startY : float
var wordPair

func _ready() -> void:
	startY = $StaticBody3D/MeshInstance3D.get_position().y

func _process(delta: float) -> void:
	$StaticBody3D/MeshInstance3D.get_position().y = startY + sin(Time.get_ticks_usec()/100000)*0.05;

func SetWordPair(pair):
	wordPair=pair
	
func GetWordPair():
	return wordPair
