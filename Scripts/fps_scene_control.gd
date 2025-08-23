extends Node3D

var ideaPlaced=0
var ideaToPlace=1

@export var exitDoor : Node3D

func IdeaPlaced():
	ideaPlaced=ideaPlaced+1
	print("idea placed")
	
	if ideaToPlace == ideaPlaced:
		print("all idea found, leave level")
		exitDoor.unlock()
