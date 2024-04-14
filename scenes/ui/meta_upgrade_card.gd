extends PanelContainer
class_name MetaUpgradeCard

@onready var label_nome: Label = %Nome
@onready var label_descricao: Label = %Descricao
@onready var hover_animation_player: AnimationPlayer = $HoverAnimationPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_upgrade_abilidade(upgrade: UpgradeAbilidade) -> void:
	label_nome.text = upgrade.nome
	label_descricao.text = upgrade.descricao


func selecionar_card() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		
	animation_player.play("selecionado")
	

func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	hover_animation_player.play("mouse_hover")


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		selecionar_card()
