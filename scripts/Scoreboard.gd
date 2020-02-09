extends Node2D

var score = 0
var rounds = 0

var correct = null
var fail = null

func _ready():
	correct = get_node("correct")
	fail = get_node("fail")

func scoreboardInit():
	get_node("Instructions").visible = false
	get_node("ScoreLabel").visible = true
	
	correct.visible = false
	fail.visible = false

func addFail():
	scoreboardInit()
	
	var perf = get_node("PerformanceLabel")
	rounds += 1
	
	perf.text = str(score) + "  out of  " + str(rounds)
	perf.visible = true
	
	fail.visible = true


func clearStatus():
	fail.visible = false
	correct.visible = false

func addSuccess():
	scoreboardInit()
	
	var perf = get_node("PerformanceLabel")
	rounds += 1
	score += 1
	
	perf.text = str(score) + "  out of  " + str(rounds)
	perf.visible = true
	
	correct.visible = true

