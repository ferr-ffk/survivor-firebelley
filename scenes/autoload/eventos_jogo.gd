extends Node
class_name EventosJogo

signal frasco_experiencia_coletado(n: float)

func emitir_frasco_experiencia_coletado(n: float) -> void:
	frasco_experiencia_coletado.emit()
