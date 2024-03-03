extends CanvasLayer
class_name TelaUpgrade

@export var upgrade_abilidade_card: PackedScene

@onready var container_card: HBoxContainer = %ContainerCard

func set_upgrade_abilidade(upgrades: Array[UpgradeAbilidade]) -> void:
	for upgrade in upgrades:
		var instancia_card: UpgradeAbilidadeCard = upgrade_abilidade_card.instantiate()
		
		container_card.add_child(instancia_card)
		instancia_card.set_upgrade_abilidade(upgrade)
		
		
