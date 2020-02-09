extends Sprite


var song = [
	"g0", "g2", "g4", "g0", "", "g0", "g2", "g4", "g0", "g4", "g5", "g7", "g4",
	"g5", "g7", "",
	"b3", "b5", "b3", "b1", "b0", "g0", "b3", "b5", "b3", "b1", "b0", "g0",
	"g0", "d0", "g0", "", "g0", "d0", "g0"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func playSong1():
	playSong(song)

func playSong(s):
	for n in s:
		if n != "":
			var nodePlaying = playNote(n)
			nodePlaying.play()
			yield(nodePlaying, "finished")
			nodePlaying.queue_free()
		else:
			var t = Timer.new()
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()


func playNote(note):
	var sourceStream = load("res://audio/" + note + ".wav")
	var audioPlayingNode = AudioStreamPlayer.new()
	audioPlayingNode.set_stream(sourceStream)
	
	add_child(audioPlayingNode)
	audioPlayingNode.add_to_group("streams")
	
	return audioPlayingNode
