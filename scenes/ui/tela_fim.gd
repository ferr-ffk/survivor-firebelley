extends CanvasLayer
class_name TelaFim

@onready var label_titulo: Label = %LabelTitulo
@onready var label_texto: Label = %LabelTexto

func _ready() -> void:
	get_tree().paused = true


func set_vitoria(vitoria: bool = true):
	if vitoria:
		label_titulo.text = "Vitória!"
		label_texto.text = "Você ganhou... parabéns!"
	else:
		label_titulo.text = "Derrota..."
		label_texto.text = "Você perdeu, poxa!"


func _on_botao_jogar_novamente_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/principal/principal.tscn")


func _on_botao_sair_pressed() -> void:
	get_tree().quit()
