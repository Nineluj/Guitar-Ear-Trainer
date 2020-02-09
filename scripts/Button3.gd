extends Button

func _pressed():
	global.level = 3
	get_tree().change_scene("res://scenes/playScene.tscn")
