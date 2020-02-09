extends CollisionShape2D


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var gNode = get_node("Guitar")
		var pressed = gNode.noteSelected(event.position)
		print("Pressed: " + pressed)
		gNode.playNote(pressed)
