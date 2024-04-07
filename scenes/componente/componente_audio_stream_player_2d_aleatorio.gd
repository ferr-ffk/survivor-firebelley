extends AudioStreamPlayer2D
class_name ComponenteAudioStreamPlayer2DAleatorio

@export var streams: Array[AudioStream]

func play_aleatorio() -> void:
	if streams == null || streams.size() == 0:
		printerr("Nenhuma stream escolhida!")
		return
	
	stream = streams.pick_random() as AudioStream
	
	play()
