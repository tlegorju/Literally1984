extends AudioStreamPlayer3D

@onready var luckySound: AudioStreamPlayer3D = $LuckySound
var isLucky = false;

func _ready():
	GameManager.radio_toggle.connect(toggle);

func toggle():
	if(isLucky || randi() % 2 == 0):
		isLucky = !isLucky;
		luckySound.playing = !luckySound.playing;
	else:
		playing = !playing;
	
