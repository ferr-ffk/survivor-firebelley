extends Node
class_name GerenciadorExperiencia

signal experiencia_atualizada(experiencia_atual: float, experiencia_maxima: float)
signal nivel_upgrade(novo_nivel: int)

const AUMENTO_DE_EXPERIENCIA_POR_NIVEL = 10

@export var experiencia_atual = 0
@export var nivel_atual = 1
@export var experiencia_maxima = 5

func _ready() -> void:
	# conecta ao sinal global de frasco experiencia coletada
	EventosJogo.frasco_experiencia_coletado.connect(on_frasco_experiencia_coletado)


func aumentar_experiencia(n: float) -> void:
	experiencia_atual = min(experiencia_atual + n, experiencia_maxima)
	experiencia_atualizada.emit(experiencia_atual, experiencia_maxima)
	
	# a cada nivel alcançado, aumenta o número atual do nivel, e o número de experiencia
	# necessaria para subir de nivel
	if experiencia_atual == experiencia_maxima:
		nivel_atual += 1
		experiencia_maxima += AUMENTO_DE_EXPERIENCIA_POR_NIVEL
		experiencia_atual = 0
		
		experiencia_atualizada.emit(experiencia_atual, experiencia_maxima)
		nivel_upgrade.emit(nivel_atual)

func on_frasco_experiencia_coletado(n: float) -> void:
	aumentar_experiencia(n)
