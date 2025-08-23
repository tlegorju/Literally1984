extends Node3D

@export var pickup : Node3D
var canPickup : bool = true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func interact():
	var fpsChar = get_parent().get_node("FPSChar")
	if not fpsChar:
		return
	if fpsChar.hasPickup():
		if not canPickup:
			print("impossible bruh")
			return
		pickup = fpsChar.getPickup()
		fpsChar.setPickup(null)
		pickup.set_position($PickupPlacement.get_global_position())
		pickup.visible=true
		get_tree().get_root().get_node("Root_FPS").IdeaPlaced()
	else:
		fpsChar.setPickup(pickup)
		pickup.visible=false
		pickup=null
		
