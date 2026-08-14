extends Control

@export var MMContainer : Container
@export var OptionsContainer : Container
@export var CreditsContainer : Container

func _ready() -> void:
	backToMainMenu()

func play():
	GameManager.goToMainScene()
	
func options():
	MMContainer.hide()
	OptionsContainer.show()
	CreditsContainer.hide()
	return
	
func credits():
	MMContainer.hide()
	OptionsContainer.hide()
	CreditsContainer.show()
	return
	
func quit():
	get_tree().quit()

func backToMainMenu():
	MMContainer.show()
	OptionsContainer.hide()
	CreditsContainer.hide()
