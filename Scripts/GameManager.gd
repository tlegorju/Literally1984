extends Node


enum WordType {OLD_WORD, NEW_WORD, NEUTRAL_WORD}

var words = []
var curStep : int = 0
var maxStep : int = 8

var corrected_word=false
var go_correct_word=false
var dialog_word1
var dialog_word2
var dialog_word3

@export var player: CharacterBody3D;

var next_dialogue;
var next_dialogue_name;
var next_pos;
var next_max_dist;
var next_signal;

func _ready() -> void:
	#player = get_tree().get_first_node_in_group("Player");
	words.clear()
	
	var stepArray = []	
	stepArray.append({
	"oldWord": "HOME",
	"newWord": "TO WORK" })
	words.append(stepArray)
	
	#stepArray.clear()
	var stepArray2 = []
	stepArray2.append({
	"oldWord": "DOG",
	"newWord": "NATION" })
	words.append(stepArray2)
	
	#stepArray.clear()
	var stepArray3 = []
	stepArray3.append({
	"oldWord": "destroy",
	"newWord": "reeducate" })
	stepArray3.append({
	"oldWord": "boss",
	"newWord": "partner" })
	words.append(stepArray3)
	
	var stepArray4 = []
	stepArray4.append({
	"oldWord": "propaganda",
	"newWord": "facts" })
	stepArray4.append({
	"oldWord": "kidnap",
	"newWord": "help" })
	words.append(stepArray4)
	
	setDialogWord()
		
func try_show_dialog(next_dia, next_dia_name, next_p, next_max_d, next_sign):
	next_dialogue = next_dia;
	next_dialogue_name = next_dia_name;
	next_pos = next_p;
	next_max_dist = next_max_d;
	next_signal = next_sign;
	
func _process(delta):
	player = get_tree().get_first_node_in_group("Player")
	if(player and next_dialogue):
		print(next_dialogue)
		var dist = player.get_global_position() - next_pos;
		if(dist.length() <= next_max_dist):
			DialogueManager.show_dialogue_balloon(next_dialogue, next_dialogue_name);
			if next_signal:
				next_signal.emit();
			next_dialogue = null;
	
func getCurWords():
	if curStep>=0 && curStep < maxStep:
		return words[curStep]
	return []
	
func nextStep():
	curStep = curStep+1
	go_correct_word=false
	corrected_word=false
	setDialogWord()
	
func isFinished():
	return curStep == maxStep
	
func goToMinigameScene():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://Scenes/inception_scene.tscn")
	
func goToMainScene():
	setDialogWord()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")

func setDialogWord():
	var curWords = getCurWords()
	dialog_word1 = curWords[0]["newWord"] if corrected_word else curWords[0]["oldWord"]
	if curWords.size()>=2:
		dialog_word2 = curWords[1]["newWord"] if corrected_word else curWords[1]["oldWord"]
	if curWords.size()>=3:
		dialog_word3 = curWords[2]["newWord"] if corrected_word else curWords[2]["oldWord"]

func launchDialog():
	var dial = load("res://Dialogs/main_dialogs.dialogue")
	var tag = "step_"+str(curStep+1)
	DialogueManager.show_dialogue_balloon(dial, tag)		
