extends Node3D


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		var dial = load("res://Dialogs/main_dialogs.dialogue")
		var tag = "step_"+str(GameManager.curStep+1)
		GameManager.try_show_dialog(dial, tag, get_global_position(), 1.5, null)
		#GameManager.launchDialog()
		
func _on_area_3d_mouse_entered() -> void:
	CursorControl.set_cursor_hover(true)

func _on_area_3d_mouse_exited() -> void:
	CursorControl.set_cursor_hover(false)
	
