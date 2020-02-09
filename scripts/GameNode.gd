extends Node2D

var songs = [[
	"g0", "g2", "g4", "g0", "", "g0", "g2", "g4", "g0", "g4", "g5", "g7", "g4",
	"g5", "g7", "",
	"b3", "b5", "b3", "b1", "b0", "g0", "b3", "b5", "b3", "b1", "b0", "g0",
	"g0", "d0", "g0", "", "g0", "d0", "g0"
]]

var currentNote = 0
var currentSong = []
var guitar = null
var scoreboard = null

func _ready():
	print("Loaded with level", global.level)

	scoreboard = get_node("Scoreboard")
	guitar = get_node("GuitarInst/Area2D/CollisionShape2D/Guitar")
	currentSong = songs[global.level - 1]
	
	playRound()
	

func playRound():
	yield(guitar.playNote(currentSong[currentNote]), "finished")
	guitar.playNoteNoShow(currentSong[currentNote + 1])
	
	guitar.connect("note_played", self, "checkNext")

func checkNext(nn):
	guitar.disconnect("note_played", self, "checkNext")
	yield(get_tree().create_timer(2), "timeout")
	
	if nn == currentSong[currentNote + 1]:
		scoreboard.addSuccess()
		currentNote += 1
		
		if currentNote == len(currentSong):
			displayComplete()
			return
	
	else:
		scoreboard.addFail()
	
	playRound()

func displayComplete():
	print("Do something now??")
