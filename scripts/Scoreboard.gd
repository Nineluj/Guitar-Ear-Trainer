extends Node2D

var score = 0
var rounds = 0

func scoreboardInit():
	get_node("Instructions").visible = false
	get_node("ScoreLabel").visible = true

func addFail():
	scoreboardInit()
	
	var perf = get_node("PerformanceLabel")
	rounds += 1
	
	perf.text = str(score) + "out of " + str(rounds)
	perf.visible = true

func addSuccess():
	scoreboardInit()
	
	var perf = get_node("PerformanceLabel")
	rounds += 1
	score += 1
	
	perf.text = str(score) + "out of " + str(rounds)
	perf.visible = true
