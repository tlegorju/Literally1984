extends Node3D

@export var spawnProba: float = 0.5
@export var props: Array[PackedScene] #props spawnable
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	for scene in ResourceLoader.list_directory("res://Scenes/playfabs/Props"):
		print(scene)
		var tmpResource = ResourceLoader.load("res://Scenes/playfabs/Props/"+scene, "PackedScene")
		props.append(tmpResource)
	
	var needSpawn: bool = rng.randf() <= spawnProba
	if needSpawn:
		var propIdx: int = rng.randi_range(0, props.size()-1)
		print("Instantiate prop ", propIdx, " out of ", props.size())
		if(propIdx >= 0 && propIdx < props.size()):
			var newProp = props[propIdx].instantiate()	
			self.add_child(newProp)
			newProp.set_global_position(self.get_global_position())
