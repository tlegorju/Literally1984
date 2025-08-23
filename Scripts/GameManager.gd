extends Node

var words = []
var curInterrogationStep : int = 0

func loadLevelWordData():
	words.empty()
	words.append({
	"oldWord": "free",
	"newWord": "efficient" })
	words.append({
	"oldWord": "peaceful",
	"newWord": "useful" })
	
func getWords():
	return words
