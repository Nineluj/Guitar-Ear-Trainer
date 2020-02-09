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

func transposeDown(n):
	if n[0] == "he":
		return ["", -1]
	
	var n_index = notesArr.find(n[0])
	
	if n[0] == "g":
		return [notesArr[n_index + 1], n[1] - 4]
	else:
		return [notesArr[n_index + 1], n[1] - 5]
		

func splitUp(n: String):
	if n.begins_with("he"):
		return [n.left(2), int(n.right(2))]
	else:
		return [n.left(1), int(n.right(1))]

func sameNotes(a: String, b: String):
	print(a, b)
	if a == b:
		return true
	
	var asp = splitUp(a)
	var bsp = splitUp(b)
	
	return sameNotesRecc(asp, bsp)

func sameNotesRecc(asp, bsp):
	if asp[0] == bsp[0]:
		return int(abs(asp[1] - bsp[1])) % 12 == 0
	
	var asp_index = notesArr.find(asp[0])
	var bsp_index = notesArr.find(bsp[0])
	
	if asp_index < bsp_index:
		var a_down = transposeDown(asp)
		
		if a_down[1] < 0:
			return false
		
		return sameNotesRecc(a_down, bsp)
	else:
		
		var b_down = transposeDown(bsp)
		
		if b_down[1] < 0:
			return false
		
		return sameNotesRecc(asp, b_down)

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
	
	if sameNotes(nn, currentSong[currentNote + 1]):
		currentSong[currentNote + 1] = nn
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
