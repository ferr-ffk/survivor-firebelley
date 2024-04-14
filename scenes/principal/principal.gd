extends Node

@export var tela_fim: PackedScene

var menu_pausa = preload("res://scenes/ui/menu_pausa.tscn")


## para inputs mapeados que não foram manipulados por nenhum node
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		add_child(menu_pausa.instantiate())
		
		# define o input como manipulado, para que nenhum outro node consiga alterar
		get_tree().root.set_input_as_handled()


func _on_jogador_morte() -> void:
	var tela_morte: TelaFim = tela_fim.instantiate()
	

	add_child(tela_morte)
	tela_morte.set_vitoria(false)
