extends CanvasLayer
class_name MenuPrincipal

var menu_opcoes = preload("res://scenes/ui/menu_opcoes.tscn")


func _on_botao_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/principal/principal.tscn")


func _on_botao_opcoes_pressed() -> void:
	var instancia_menu_opcoes = menu_opcoes.instantiate() as MenuOpcoes
	
	add_child(instancia_menu_opcoes)
	
	instancia_menu_opcoes.voltar_pressionado.connect(_on_botao_voltar_pressionado.bind(instancia_menu_opcoes))


func _on_botao_voltar_pressionado(instancia_menu_opcoes: Node) -> void:
	instancia_menu_opcoes.queue_free()
	

func _on_botao_sair_pressed() -> void:
	get_tree().quit()
