extends Button
class_name BotaoSom

@onready var componente_audio_stream_player_aleatorio: ComponenteAudioStreamPlayerAleatorio = $ComponenteAudioStreamPlayerAleatorio

func _ready() -> void:
	pressed.connect(_on_botao_som_pressionado)
	

func _on_botao_som_pressionado() -> void:
	componente_audio_stream_player_aleatorio.play_aleatorio()
	
