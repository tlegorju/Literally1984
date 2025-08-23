extends Node3D

var wordPair
@export var wordType = GameManager.WordType.NEUTRAL_WORD

@export var door : Node3D
@export var doorText : Node3D
@export var pedestal : Node3D
@export var pickupPivot : Node3D

@export var Pickup : PackedScene

func InitRoom(newWord, newWordType):
	wordPair = newWord
	wordType = newWordType
	if wordType == GameManager.WordType.NEW_WORD:
		doorText.text = wordPair["newWord"]
	elif wordType == GameManager.WordType.OLD_WORD:
		doorText.text = wordPair["oldWord"]
		
	if wordType == GameManager.WordType.OLD_WORD:
		var newPickup = Pickup.instantiate()
		get_tree().get_root().get_node("/root/Root_FPS").add_child(newPickup)
		newPickup.set_global_position(pickupPivot.get_global_position())
		newPickup.SetWordPair(wordPair)
		pedestal.initPickup(newPickup)
