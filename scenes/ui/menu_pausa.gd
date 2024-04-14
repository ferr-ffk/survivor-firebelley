extends CanvasLayer
class_name MenuPausa

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var container_botoes: PanelContainer = %ContainerBotoes

var cena_menu_opcoes = preload("res://scenes/ui/menu_opcoes.tscn")

var fechando_cena: bool

func _ready() -> void:
	get_tree().paused = true
	
	animation_player.play("padrao")	
	
	var tween = get_tree().create_tween()
	
	# garante que o container terá uma escala de zero ao iniciar a animação
	tween.tween_property(container_botoes, "scale", Vector2.ZERO, 0)
	
	tween.tween_property(container_botoes, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
		
		
func fechar_cena() -> void:
	if fechando_cena:
		return
	
	# para que a animação não seja interrompida no meio por vários inputs seguidos
	fechando_cena = true
	
	animation_player.play_backwards("padrao")
	
	var tween = create_tween()
	
	container_botoes.pivot_offset = container_botoes.size / 2
	
	# garante que o container terá uma escala de zero ao iniciar a animação
	tween.tween_property(container_botoes, "scale", Vector2.ONE, 0)
	
	tween.tween_property(container_botoes, "scale", Vector2.ZERO, 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
		
	# aguarda o termino da animação para deletar a cena atual e voltar para o jogo
	await tween.finished
	get_tree().paused = false
	queue_free()
		
		
## para inputs mapeados que não foram manipulados por nenhum node
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		fechar_cena()
		
		# define o input como manipulado, para que nenhum outro node consiga alterar
		get_tree().root.set_input_as_handled()


func _on_voltar_pressionado(menu_opcoes: Node) -> void:
	menu_opcoes.queue_free()


func _on_botao_retomar_pressed() -> void:
	fechar_cena()


func _on_botao_opcoes_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	var menu_opcoes = cena_menu_opcoes.instantiate() as MenuOpcoes
	
	add_child(menu_opcoes)
	menu_opcoes.voltar_pressionado.connect(_on_voltar_pressionado.bind(menu_opcoes))


func _on_botao_sair_menu_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	get_tree().paused = false
	
	get_tree().change_scene_to_file("res://scenes/ui/menu_principal.tscn")
