extends Node3D

@export var pickup : Node3D
var canPickup : bool = true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func initPickup(newPickup):
	pickup=newPickup

func interact():
	var fpsChar = get_tree().get_root().get_node("/root/Root_FPS/FPSChar")
	if not fpsChar:
		return
	if fpsChar.hasPickup() and pickup==null:
		var tmpPickup = fpsChar.getPickup()
		var wordType = get_parent().wordType
		var parentPair = get_parent().wordPair
		
		if wordType == GameManager.WordType.NEW_WORD and parentPair["newWord"] == tmpPickup.GetWordPair()["newWord"]:
			pickup = tmpPickup
			fpsChar.setPickup(null)
			pickup.reparent(get_tree().get_root().get_node("/root/Root_FPS"))
			pickup.set_position($PickupPlacement.get_global_position())
			pickup.visible=true
			get_tree().get_root().get_node("Root_FPS").IdeaPlaced()
			canPickup=false
		else:
			var dial = load("res://Dialogs/minigame_tips.dialogue")
			DialogueManager.show_dialogue_balloon(dial, "wrong_place")			
			
	elif not fpsChar.hasPickup() and canPickup:
		fpsChar.setPickup(pickup)
		#pickup.visible=false
		pickup=null
		if not DialogGlobals.has_pickedup:
			var dial = load("res://Dialogs/minigame_tips.dialogue")
			DialogueManager.show_dialogue_balloon(dial, "found_thought")
		
