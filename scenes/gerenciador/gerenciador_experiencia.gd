extends Node
class_name GerenciadorExperiencia

signal experiencia_atualizada(experiencia_atual: float, experiencia_maxima: float)

const AUMENTO_DE_EXPERIENCIA_POR_NIVEL = 10

var experiencia_atual = 0.0
var nivel_atual = 1
var experiencia_maxima = 5

func _ready() -> void:
	# conecta ao sinal global de frasco experiencia coletada
	EventosJogo.frasco_experiencia_coletado.connect(on_frasco_experiencia_coletado)


func aumentar_experiencia(n: float) -> void:
	experiencia_atual = min(nivel_atual + n, experiencia_maxima)
	experiencia_atualizada.emit(experiencia_atual, experiencia_maxima)
	
	# a cada nivel alcançado, aumenta o número atual do nivel, e o número de experiencia
	# necessaria para subir de nivel
	if experiencia_atual == experiencia_maxima:
		nivel_atual += 1
		experiencia_maxima += AUMENTO_DE_EXPERIENCIA_POR_NIVEL
		experiencia_atual = 0
		
		experiencia_atualizada.emit(experiencia_atual, experiencia_maxima)

func on_frasco_experiencia_coletado(n: float) -> void:
	aumentar_experiencia(n)
