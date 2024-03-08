extends Node


@export var tela_fim: PackedScene


func _on_jogador_morte() -> void:
	var tela_morte: TelaFim = tela_fim.instantiate()
	

	add_child(tela_morte)
	tela_morte.set_vitoria(false)
