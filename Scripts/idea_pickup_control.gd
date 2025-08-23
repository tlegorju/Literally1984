extends Node3D

var startY : float

func _ready() -> void:
	startY = position.y

func _process(delta: float) -> void:
	position.y = startY + sin(Time.get_ticks_usec()/100000)*0.05;
