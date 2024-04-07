extends AudioStreamPlayer2D
class_name ComponenteAudioStreamPlayer2DAleatorio

@export var streams: Array[AudioStreamPlayer2D]

func play_aleatorio() -> void:
	if streams == null || streams.size() == 0:
		printerr("Nenhuma stream escolhida!")
		return
	
	var stream = streams.pick_random() as AudioStreamPlayer2D
	
	stream.play()
	
