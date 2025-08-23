extends Node

var hoverCursor : Resource = preload("res://tmp_art/inspect.png")
var freeCursor : Resource = preload("res://tmp_art/select.png")

func _init() -> void:
	Input.set_custom_mouse_cursor(freeCursor)

func set_cursor_hover(hover: bool):
	if hover:
		Input.set_custom_mouse_cursor(hoverCursor)
	else:
		Input.set_custom_mouse_cursor(freeCursor)
