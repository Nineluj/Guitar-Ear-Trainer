extends Sprite


var song = [
	"g0", "g2", "g4", "g0", "", "g0", "g2", "g4", "g0", "g4", "g5", "g7", "g4",
	"g5", "g7", "",
	"b3", "b5", "b3", "b1", "b0", "g0", "b3", "b5", "b3", "b1", "b0", "g0",
	"g0", "d0", "g0", "", "g0", "d0", "g0"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	playSong(song)

func playSong(s):
	for n in s:
		if n != "":
			playNote(n)
		OS.delay_msec(500)

func playNote(note):
	var sourceStream = load("res://audio/" + note + ".wav")
	var audioPlayingNode = AudioStreamPlayer.new()
	audioPlayingNode.set_stream(sourceStream)
	
	add_child(audioPlayingNode)
	audioPlayingNode.add_to_group("streams")
	audioPlayingNode.play()
	
