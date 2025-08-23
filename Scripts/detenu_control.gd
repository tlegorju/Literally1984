extends CharacterBody3D


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	#eliminate intruder
	if event.is_action("select"):
		var dialogResource = preload("res://Dialogs/test_dialog.dialogue")
		DialogueManager.show_dialogue_balloon(dialogResource, "test_dialog") 

func on_hover():
	CursorControl.set_cursor_hover(true)
	
func on_unhover():
	CursorControl.set_cursor_hover(false)
