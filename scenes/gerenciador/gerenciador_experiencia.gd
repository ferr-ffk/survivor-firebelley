extends Node

var experiencia_atual = 0.0

func _ready() -> void:
	# conecta ao sinal global de frasco experiencia coletada
	EventosJogo.frasco_experiencia_coletado.connect(on_frasco_experiencia_coletado)


func aumentar_experiencia(n: float) -> void:
	experiencia_atual += n


func on_frasco_experiencia_coletado(n: float) -> void:
	aumentar_experiencia(n)
