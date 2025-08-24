extends Node


enum WordType {OLD_WORD, NEW_WORD, NEUTRAL_WORD}

var words = []
var curStep : int = 0
var maxStep : int = 3

var corrected_word=false
var dialog_word1
var dialog_word2
var dialog_word3

func _ready() -> void:
	words.clear()
	
	var stepArray = []	
	stepArray.append({
	"oldWord": "HOME",
	"newWord": "TO WORK" })
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
	
	setDialogWord()
	
func getCurWords():
	if curStep>=0 && curStep < maxStep:
		return words[curStep]
	return []
	
func nextStep():
	curStep = curStep+1
	setDialogWord()
	
func isFinished():
	return curStep == maxStep
	
func goToMinigameScene():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://Scenes/inception_scene.tscn")
	
func goToMainScene():
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
	var dial = load("res://Dialogs/minigame_tips.dialogue")
	var tag = "step_"+str(curStep+1)
	DialogueManager.show_dialogue_balloon(dial, "exit")		
