extends CanvasLayer
class_name MenuAjuda


func _on_botao_jogar_pressed() -> void:
	TransicaoTela.transicao_para_cena("res://scenes/principal/principal.tscn")
