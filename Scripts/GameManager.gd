extends Node


enum WordType {OLD_WORD, NEW_WORD, NEUTRAL_WORD}

var words = []
var curStep : int = 0
var maxStep : int = 3

var player: CharacterBody3D;

var next_dialogue;
var next_dialogue_name;
var next_pos;
var next_max_dist;
var next_signal;

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player");
	words.clear()
	
	var stepArray = []	
	stepArray.append({
	"oldWord": "free",
	"newWord": "efficient" })
	words.append(stepArray)
	
	#stepArray.clear()
	var stepArray2 = []
	stepArray2.append({
	"oldWord": "peaceful",
	"newWord": "useful" })
	stepArray2.append({
	"oldWord": "lazy",
	"newWord": "busy" })
	words.append(stepArray2)
	
	#stepArray.clear()
	var stepArray3 = []
	stepArray3.append({
	"oldWord": "timeoff",
	"newWord": "work" })
	stepArray3.append({
	"oldWord": "boss",
	"newWord": "partner" })
	stepArray3.append({
	"oldWord": "system",
	"newWord": "individual" })
	words.append(stepArray3)
	
func try_show_dialog(next_dia, next_dia_name, next_p, next_max_d, next_sign):
	next_dialogue = next_dia;
	next_dialogue_name = next_dia_name;
	next_pos = next_p;
	next_max_dist = next_max_d;
	next_signal = next_sign;
	
func _process(delta):
	if(next_dialogue):
		print(next_dialogue)
		var dist = player.get_global_position() - next_pos;
		if(dist.length() <= next_max_dist):
			DialogueManager.show_dialogue_balloon(next_dialogue, next_dialogue_name);
			next_signal.emit();
			next_dialogue = null;
	
func getCurWords():
	if curStep>=0 && curStep < maxStep:
		return words[curStep]
	return []
	
func nextStep():
	curStep = curStep+1
	
func isFinished():
	return curStep == maxStep
	
func goToMinigameScene():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://Scenes/inception_scene.tscn")
	
func goToMainScene():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")
