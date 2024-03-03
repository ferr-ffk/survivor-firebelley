extends PanelContainer
class_name UpgradeAbilidadeCard

@onready var label_nome: Label = %Nome
@onready var label_descricao: Label = %Descricao

func set_upgrade_abilidade(upgrade: UpgradeAbilidade) -> void:
	label_nome.text = upgrade.nome
	label_descricao.text = upgrade.descricao
