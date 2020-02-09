extends Sprite

signal note_played

func noteToPos(n: String):
	var letter = ""
	var fret = -1
	
	if n.begins_with("he"):
		letter = n.left(2)
		fret = int(n.right(1))
	else:
		letter = n.left(1)
		fret = int(n.right(1))
	

	var x = 0
	var y = 0
	
	if letter == "he":
		y = 278
	elif letter == "b":
		y = 293
	elif letter == "g":
		y = 307
	elif letter == "d":
		y = 323
	elif letter == "a":
		y = 338
	elif letter == "E":
		y = 353
	
	if fret == 1:
		x = 169
	elif fret == 2:
		x = 221
	elif fret == 3:
		x = 270
	elif fret == 4:
		x = 315
	elif fret == 5:
		x = 357
	elif fret == 6:
		x = 398
	elif fret == 7:
		x = 437
	elif fret == 8:
		x = 474
	elif fret == 9:
		x = 512
	elif fret == 10:
		x = 550
	elif fret == 11:
		x = 582
	elif fret == 12:
		x = 612
	elif fret == 13:
		x = 642
	elif fret == 14:
		x = 673
	elif fret == 15:
		x = 705
	else:
		x = 880
	
	return [x,y]

func drawNote(n):
	var p = self.noteToPos(n)
	var shadow = get_parent().get_node("shadow")
	
	shadow.position.x = p[0] - 570
	shadow.position.y = p[1] - 316
	
	shadow.visible = true

func noteSelected(pos_tuple):
	var letter = ""
	var fret = -1
	
	var x = pos_tuple[0]
	var y = pos_tuple[1]
	
	if y < 280:
		letter = "he"
	elif y < 293:
		letter = "b"
	elif y < 303:
		letter = "g"
	elif y < 315:
		letter = "d"
	elif y < 323:
		letter = "a"
	else:
		letter = "E"
	
	if x < 189:
		fret = 1
	elif x < 224:
		fret = 2
	elif x < 256:
		fret = 3
	elif x < 287:
		fret = 4
	elif x < 313:
		fret = 5
	elif x < 343:
		fret = 6
	elif x < 371:
		fret = 7
	elif x < 395:
		fret = 8
	elif x < 422:
		fret = 9
	elif x < 448:
		fret = 10
	elif x < 468:
		fret = 11
	elif x < 490:
		fret = 12
	elif x < 510:
		fret = 13
	elif x < 533:
		fret = 14
	elif x < 556:
		fret = 15
	else:
		fret = 0
		
	emit_signal("note_played", letter + str(fret))
	
	return letter + str(fret)


func playSong(s):
	for n in s:
		if n != "":
			var nodePlaying = playNote(n)
			yield(nodePlaying, "finished")
			nodePlaying.queue_free()
		else:
			var t = Timer.new()
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()

func playNoteNoShow(note):
	var sourceStream = load("res://audio/" + note + ".wav")
	var audioPlayingNode = AudioStreamPlayer.new()
	audioPlayingNode.set_stream(sourceStream)
	
	add_child(audioPlayingNode)
	audioPlayingNode.add_to_group("streams")
	audioPlayingNode.play()
	
	return audioPlayingNode

func playNote(note):
	var sourceStream = load("res://audio/" + note + ".wav")
	var audioPlayingNode = AudioStreamPlayer.new()
	audioPlayingNode.set_stream(sourceStream)
	
	add_child(audioPlayingNode)
	audioPlayingNode.add_to_group("streams")
	audioPlayingNode.play()
	drawNote(note)
	
	return audioPlayingNode
