extends Node
class_name FrascoExperiencia

@export var experiencia: int = 2

func _on_area_coleta_jogador_area_entered(area: Area2D) -> void:
	EventosJogo.emitir_frasco_experiencia_coletado(experiencia)
	queue_free()
