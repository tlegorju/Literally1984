extends AudioStreamPlayer3D

@export var lowerDB: float;
var baseDB: float;

func _ready() -> void:
	baseDB = max_db;

func on_leave(body):
	max_db = lowerDB;
	
func on_enter(body):
	max_db = baseDB;
