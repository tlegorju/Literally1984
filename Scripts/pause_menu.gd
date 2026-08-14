extends Control

var prevMouseMode = Input.MOUSE_MODE_VISIBLE

func toggle_menu():
	if self.is_visible_in_tree():
		self.hide()
		Input.set_mouse_mode(prevMouseMode)
	else:
		self.show()
		prevMouseMode = Input.get_mouse_mode()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	return

func resume():
	self.toggle_menu()
		
func quit():
	GameManager.goToMainMenu()
