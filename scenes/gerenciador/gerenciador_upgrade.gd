extends Node
class_name GerenciadorUpgrade

@export var upgrades_disponiveis: Array[UpgradeAbilidade]
@export var gerenciador_experiencia: GerenciadorExperiencia

var upgrades_atuais: Dictionary = {}

func _ready() -> void:
	gerenciador_experiencia.nivel_upgrade.connect(on_nivel_upgrade)


func on_nivel_upgrade(nivel_atual: int) -> void:
	var upgrade_escolhido: UpgradeAbilidade = upgrades_disponiveis.pick_random()
	
	# pick_random() pode retornar nulo, então se certifica que irá pegar um upgrade valido
	if upgrade_escolhido == null:
		on_nivel_upgrade(nivel_atual)
	
	var upgrade_existente: bool = upgrades_atuais.has(upgrade_escolhido.id)
	
	# anexa o upgrade na lista de upgrades do jogador, se ele já existir, aumenta o nivel dele
	if !upgrade_existente:
		upgrades_atuais[upgrade_escolhido.id] = {
			"resource": upgrade_escolhido,
			"quantidade": 1
		}
	else:
		upgrades_atuais[upgrade_escolhido.id]["quantidade"] += 1

	print(upgrades_atuais)
