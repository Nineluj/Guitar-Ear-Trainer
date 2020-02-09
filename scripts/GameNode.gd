extends Node2D

var songs = [[
	"g0", "g2", "g4", "g0", "", "g0", "g2", "g4", "g0", "g4", "g5", "g7", "g4",
	"g5", "g7", "",
	"b3", "b5", "b3", "b1", "b0", "g0", "b3", "b5", "b3", "b1", "b0", "g0",
	"g0", "d0", "g0", "", "g0", "d0", "g0"
]]

var guitar = null

func _ready():
	print("Loaded with level", global.level)
	guitar = get_node("GuitarInst/Area2D/CollisionShape2D/Guitar")
	
	guitar.playNote(songs[global.level - 1][0])
