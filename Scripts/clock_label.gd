extends Label3D
var currElapsedSeconds = 1108;

func _process(delta):
	currElapsedSeconds += delta * 10;
	var min = currElapsedSeconds / 60;
	
	var hour = min / 60;
	min = int(min) % 60;
	
	var minutes;
	if(int(min) >= 10):
		minutes = str(int(min))
	else:
		minutes = "0" + str(int(min));
		
	text = str((21 + int(hour)) % 24) + ":" + minutes;

func _resetClock(body):
	currElapsedSeconds = 1108;
