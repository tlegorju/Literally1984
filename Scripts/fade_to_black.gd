extends Control

enum FadeState{
	STOPPED,
	FADE_IN,
	FADE_OUT}
	
var state = FadeState.STOPPED
@export var alpha: float = 1.0
@export var fade_speed = 0.5
var rect: ColorRect

signal fade_finished;

func _ready():
	rect = $ColorRect
	
	fade_in()

func _process(delta):
	if state==FadeState.FADE_IN:
		alpha = clamp(alpha-fade_speed*delta, 0, 1)
		rect.color.a = alpha*255
		#print(str(alpha) + " - " + str(rect.color.a))
		if alpha<=0.0:
			fade_finished.emit()
			state = FadeState.STOPPED
	elif state==FadeState.FADE_OUT:
		alpha = clamp(alpha+fade_speed*delta, 0, 1)
		rect.color.a = alpha*255
		if alpha>=1.0:
			fade_finished.emit()
			state = FadeState.STOPPED
		
func fade_in():
	state = FadeState.FADE_IN
	
func fade_out():
	state = FadeState.FADE_OUT
