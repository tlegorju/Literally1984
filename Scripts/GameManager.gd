extends Node


enum WordType {OLD_WORD, NEW_WORD, NEUTRAL_WORD}

var words = []
var curStep : int = 2
var maxStep : int = 3

func _ready() -> void:
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
	
func getCurWords():
	if curStep>=0 && curStep < maxStep:
		return words[curStep]
	return []
	
func nextStep():
	curStep = curStep+1
	
func isFinished():
	return curStep == maxStep
