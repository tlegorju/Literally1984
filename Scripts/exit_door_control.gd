extends Node3D

var isLocked = true

func interact():
	if isLocked:
		print("can't open")
	else:
		GameManager.nextStep()
		GameManager.goToMainScene()
		
func unlock():
	isLocked=false
