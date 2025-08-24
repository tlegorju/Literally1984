extends Node3D

var isOpen : bool = false
var target_rotation : float = 0
var rotation_speed : float = 20
var pivot

@export var timer : Timer

func _ready():
	pivot = $Pivot

func _process(delta: float) -> void:
	if abs(pivot.rotation_degrees.y-target_rotation) > 0.01:
		pivot.rotation_degrees.y = lerp(pivot.rotation_degrees.y, target_rotation, rotation_speed*delta)
	else:
		$Pivot/CollisionShape3D.disabled=false

func interact():
	if isOpen:
		close_door()
	else:
		open_door()
		timer.start()

func open_door():
	target_rotation = 90
	$Pivot/CollisionShape3D.disabled=true
	isOpen=true
	pass
	
func close_door():
	target_rotation = 0
	$Pivot/CollisionShape3D.disabled=true
	isOpen=false
	timer.stop()
	pass


func _on_timer_timeout() -> void:
	if isOpen:
		close_door()
