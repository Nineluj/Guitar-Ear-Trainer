extends Button

func _pressed():
	global.level = 4
	get_tree().change_scene("res://scenes/level1.tscn")
