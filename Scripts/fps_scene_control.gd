extends Node3D

var ideaPlaced=0
var ideaToPlace=1

@export var fpsChar : Node3D

@export var roomSpacing = 6.0
@export var corridorWidth = 4.0

@export var RoomScene : PackedScene
@export var ExitDoorScene : PackedScene

var rooms = []
var exitDoors = []
var words = []

var initState=0

func _ready() -> void:
	words = GameManager.getCurWords()
	ideaToPlace = words.size()
	DialogGlobals.show_tutorial = GameManager.curStep==0

func _process(delta: float) -> void:
	if initState==0:
		InstantiateRooms()
		initState+=1
	elif initState==1:
		SetupWordsRoom()
		initState+=1
	elif initState==2 and DialogGlobals.show_tutorial:
		var dial = load("res://Dialogs/minigame_tips.dialogue")
		DialogueManager.show_dialogue_balloon(dial, "start")
		initState+=1	

func InstantiateRooms():
	var roomCount = words.size()
	rooms.clear()
	
	#place first exit door
	var curPos = fpsChar.get_position() - Vector3(2.0,0,0)
	exitDoors.append(ExitDoorScene.instantiate())
	add_child.call_deferred(exitDoors[0])
	exitDoors[0].set_position(curPos)
	
	#place rooms with words
	curPos = fpsChar.get_position() + Vector3(roomSpacing/2.0,0,0)
	for i in roomCount:
		var newRoom = RoomScene.instantiate()
		add_child.call_deferred(newRoom)
		newRoom.set_position(curPos - Vector3(0, 0, corridorWidth/2.0))
		rooms.append(newRoom)
		
		newRoom = RoomScene.instantiate()
		add_child.call_deferred(newRoom)
		newRoom.set_position(curPos + Vector3(0, 0, corridorWidth/2.0))
		newRoom.rotate_y(deg_to_rad(180))
		rooms.append(newRoom)
		
		curPos += Vector3(roomSpacing,0,0)
	
	#place second exit door
	curPos = curPos - Vector3(roomSpacing/2,0,0) + Vector3(2.0,0,0)
	exitDoors.append(ExitDoorScene.instantiate())
	add_child.call_deferred(exitDoors[1])
	exitDoors[1].set_position(curPos)
	exitDoors[1].rotate_y(deg_to_rad(180))

func SetupWordsRoom():
	rooms.shuffle()
	for i in words.size():
		rooms[i].InitRoom(words[i], GameManager.WordType.NEW_WORD)
		rooms[words.size()+i].InitRoom(words[i], GameManager.WordType.OLD_WORD)
		

func IdeaPlaced():
	ideaPlaced=ideaPlaced+1
	
	if ideaToPlace == ideaPlaced:
		var dial = load("res://Dialogs/minigame_tips.dialogue")
		DialogueManager.show_dialogue_balloon(dial, "exit")		
		for d in exitDoors:
			d.get_node("ExitDoor").unlock()
