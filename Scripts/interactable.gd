extends Node3D

@export var dialogue_resource:Resource;
@export var dialogue_name:String;
@export var max_dist:float = 1;

signal on_interact;

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	print("helppp")
	var bActivated = event.is_action("select") && event.is_pressed();
	if(!bActivated): return;
	var dist: Vector3 = get_tree().get_first_node_in_group("Player").get_global_position() - get_global_position();
	var bClose = dist.length() <= max_dist;
	print(dist.length());
	if(!bClose): return;
	
	#eliminate intruder
	if dialogue_resource:
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_name);

	on_interact.emit();

func on_hover():
	print("helppp")
	CursorControl.set_cursor_hover(true)
	
func on_unhover():
	print("no hover")
	CursorControl.set_cursor_hover(false)
	
	
