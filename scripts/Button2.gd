extends Button

func _pressed():
	global.level = 2
	get_tree().change_scene("res://scenes/playScene.tscn")
