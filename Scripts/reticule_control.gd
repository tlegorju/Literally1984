extends TextureRect

func _draw() -> void:
	if texture==null:
		draw_circle(Vector2(0, 0),2.0, Color.WHITE)
