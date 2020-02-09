extends Node2D

var songs = [
[],
["E0", "E2", "E4", "E5", "E7"],
[
	"g0", "g2", "g4", "g0", "", "g0", "g2", "g4", "g0", "g4", "g5", "g7", "g4",
	"g5", "g7", "",
	"b3", "b5", "b3", "b1", "b0", "g0", "b3", "b5", "b3", "b1", "b0", "g0",
	"g0", "d0", "g0", "", "g0", "d0", "g0"
]
]

var currentNote = 0
var currentSong = []
var guitar = null
var scoreboard = null

var notesArr = ["E", "a", "d", "g", "b", "he"]

func _ready():
	print("Loaded with level", global.level)

	scoreboard = get_node("Scoreboard")
	guitar = get_node("GuitarInst/Area2D/CollisionShape2D/Guitar")
	
	if global.level > 0:
		for n in songs[global.level]:
			if n != "":
				currentSong.append(n)
	else:
		for _i in range(10):
			currentSong.append(notesArr[randi() % len(notesArr)]
			+ str(randi() % 13))
	
	playRound()
	

func playRound():
	yield(guitar.playNote(currentSong[currentNote]), "finished")
	guitar.playNoteNoShow(currentSong[currentNote + 1])
	
	guitar.connect("note_played", self, "checkNext")

func checkNext(nn):
	scoreboard.clearStatus()
	guitar.disconnect("note_played", self, "checkNext")
	yield(get_tree().create_timer(1.5), "timeout")
	
	if nn == currentSong[currentNote + 1]:
		scoreboard.addSuccess()
		currentNote += 1
		
		if currentNote == len(currentSong) - 1:
			displayComplete()
			return
	
	else:
		scoreboard.addFail()
	
	playRound()

func displayComplete():
	get_node("EndScreen").visible = true
	guitar.playSong(currentSong)
