extends PanelContainer
class_name UpgradeAbilidadeCard

signal abilidade_selecionada(upgrade: UpgradeAbilidade)

@onready var label_nome: Label = %Nome
@onready var label_descricao: Label = %Descricao
@onready var hover_animation_player: AnimationPlayer = $HoverAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var disabled = false


func set_upgrade_abilidade(upgrade: UpgradeAbilidade) -> void:
	label_nome.text = upgrade.nome
	label_descricao.text = upgrade.descricao


func play_animacao_aparecer(delay: float = 0) -> void:
	modulate = Color.TRANSPARENT
	
	# espera o timer criado terminar para seguir com o código
	await get_tree().create_timer(delay).timeout
	
	modulate = Color.WHITE


func selecionar_card() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		
	disabled = true
	
	animation_player.play("selecionado")
	
	for card in get_tree().get_nodes_in_group("card_upgrade"):
		if not card == self:
			card.play_animacao_descarte()
	
	# espera para emitir o sinal para tela de upgrade
	await animation_player.animation_finished
	
	abilidade_selecionada.emit()


func play_animacao_descarte() -> void:
	animation_player.play("descartar")


func _on_mouse_entered() -> void:
	if not disabled:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		
		hover_animation_player.play("mouse_hover")


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_gui_input(event: InputEvent) -> void:
	if disabled:
		return
	
	if event.is_action_pressed("left_click"):
		selecionar_card()
