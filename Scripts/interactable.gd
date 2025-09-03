extends Node3D

@export var dialogue_resource:Resource;
@export var dialogue_name:String;
@export var max_dist:float = 1;

signal on_interact;

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	var bActivated = event.is_action("select") && event.is_pressed();
	if(!bActivated): return;
	GameManager.try_show_dialog(dialogue_resource, dialogue_name, get_global_position(), max_dist, on_interact);

func on_hover():
	CursorControl.set_cursor_hover(true)
	
func on_unhover():
	CursorControl.set_cursor_hover(false)
	
	
