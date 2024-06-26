extends CanvasLayer
class_name TelaFim

@onready var panel_container: PanelContainer = %PanelContainer
@onready var label_titulo: Label = %LabelTitulo
@onready var label_texto: Label = %LabelTexto
@onready var audio_derrota: AudioStreamPlayer = $AudioDerrota
@onready var audio_vitoria: AudioStreamPlayer = $AudioVitoria

func _ready() -> void:
	# centraliza o pivot
	panel_container.pivot_offset = panel_container.size / 2
	
	var tween = create_tween()
	
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true


func set_vitoria(vitoria: bool = true):
	if vitoria:
		label_titulo.text = "Vitória!"
		label_texto.text = "Você ganhou... parabéns!"
		
		audio_vitoria.play()
	else:
		label_titulo.text = "Derrota..."
		label_texto.text = "Você perdeu, poxa!"
		
		audio_derrota.play()

 
func _on_botao_jogar_novamente_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	$AnimationPlayer.play("sair")
	await $AnimationPlayer.animation_finished
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/principal/principal.tscn")


func _on_botao_sair_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/menu_principal.tscn")
