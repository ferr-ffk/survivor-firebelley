extends CanvasLayer
class_name MenuPrincipal


func _on_botao_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/principal/principal.tscn")


func _on_botao_sair_pressed() -> void:
	get_tree().quit()
