extends AudioStreamPlayer
class_name ComponenteAudioStreamPlayerAleatorio

@export var streams: Array[AudioStream]
@export_category("Tom Aleatório")
@export var aleatorizar_tom: bool = true
@export var tom_minimo: float = 0.9
@export var tom_maximo: float = 1.1


func play_aleatorio() -> void:
	if streams == null || streams.size() == 0:
		printerr("Nenhuma stream escolhida!")
		return
	
	stream = streams.pick_random() as AudioStream
	
	if aleatorizar_tom:
		pitch_scale = randf_range(tom_minimo, tom_maximo)
	else:
		pitch_scale = 1
 	
	play()
