extends AudioStreamPlayer
class_name PlayerMusicaClasse

@onready var intervalo_play_musica: Timer = $IntervaloPlayMusica

func set_tocando(tocar: bool) -> void:
	if tocar:
		play()
	else:
		stop()


func is_tocando() -> bool:
	return playing


func _on_finished() -> void:
	intervalo_play_musica.start()


func _on_intervalo_play_musica_timeout() -> void:
	play()
