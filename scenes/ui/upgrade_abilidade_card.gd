extends PanelContainer
class_name UpgradeAbilidadeCard

signal abilidade_selecionada(upgrade: UpgradeAbilidade)

@onready var label_nome: Label = %Nome
@onready var label_descricao: Label = %Descricao

func set_upgrade_abilidade(upgrade: UpgradeAbilidade) -> void:
	label_nome.text = upgrade.nome
	label_descricao.text = upgrade.descricao


## Muda o cursor do mouse para hover
func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		abilidade_selecionada.emit()
