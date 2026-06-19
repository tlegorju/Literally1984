extends AudioStreamPlayer3D

@export var lowerDB: float;
var baseDB: float;

func _ready() -> void:
	baseDB = max_db;
	volume_db = lowerDB;

func on_leave(body):
	volume_db = lowerDB;
	
func on_enter(body):
	volume_db = baseDB;
