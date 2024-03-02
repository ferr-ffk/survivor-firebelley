extends Node
class_name FrascoExperiencia

func _on_area_coleta_jogador_area_entered(area: Area2D) -> void:
	EventosJogo.emitir_frasco_experiencia_coletado(1)
	queue_free()
