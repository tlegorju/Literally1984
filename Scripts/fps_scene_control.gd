extends Node3D

var ideaPlaced=0
var ideaToPlace=1

@export var exitDoor : Node3D

@export var roomSpacing = 8.0
@export var corridorWidth = 4.0

@export var RoomScene : PackedScene

var rooms = []
var words = []

var initState=0

func _ready() -> void:
	words = GameManager.getCurWords()
	ideaToPlace = words.size()

func _process(delta: float) -> void:
	if initState==0:
		InstantiateRooms()
		initState+=1
	elif initState==1:
		SetupWordsRoom()
		initState+=1		

func InstantiateRooms():
	var roomCount = words.size()
	rooms.clear()
	
	var curPos = Vector3(roomSpacing,0,0)
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

func SetupWordsRoom():
	rooms.shuffle()
	for i in words.size():
		rooms[i].InitRoom(words[i], GameManager.WordType.NEW_WORD)
		rooms[words.size()+i].InitRoom(words[i], GameManager.WordType.OLD_WORD)
		

func IdeaPlaced():
	ideaPlaced=ideaPlaced+1
	print("idea placed")
	
	if ideaToPlace == ideaPlaced:
		print("all idea found, leave level")
		exitDoor.unlock()
