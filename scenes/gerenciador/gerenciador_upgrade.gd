extends Node
class_name GerenciadorUpgrade

@export var upgrades_disponiveis: Array[UpgradeAbilidade]
@export var gerenciador_experiencia: GerenciadorExperiencia
@export var tela_upgrade_cena: PackedScene

var upgrades_atuais: Dictionary = {}

func _ready() -> void:
	gerenciador_experiencia.nivel_upgrade.connect(on_nivel_upgrade)

## A tela de upgrade é instanciada quando o nivel muda, de acordo com o sinal do GerenciadorUpgrade
##  
## Ela mostra os upgrades disponiveis da variavel de export em forma de Card
## O Card irá escutar algum evento de click nele, se for chamado ele envia o sinal para a tela
## A tela emite esse sinal para o gerenciador de upgrade
## O gerenciador, por fim, atualiza os upgrades do jogador com o upgrade fornecido
func on_nivel_upgrade(nivel_atual: int) -> void:
	var upgrade_escolhido: UpgradeAbilidade = upgrades_disponiveis.pick_random()
	
	# pick_random() pode retornar nulo, então se certifica que irá pegar um upgrade valido
	if upgrade_escolhido == null:
		on_nivel_upgrade(nivel_atual)
		
	var tela_upgrade_instancia: TelaUpgrade = tela_upgrade_cena.instantiate()
	add_child(tela_upgrade_instancia)
	
	tela_upgrade_instancia.set_upgrade_abilidade([upgrade_escolhido] as Array[UpgradeAbilidade])
	
	tela_upgrade_instancia.upgrade_selecionado.connect(on_upgrade_selecionado)

func aplicar_upgrade(upgrade: UpgradeAbilidade) -> void:
	var upgrade_existente: bool = upgrades_atuais.has(upgrade.id)
	
	# anexa o upgrade na lista de upgrades do jogador; se ele já foi alcançado, aumenta o nivel dele
	if !upgrade_existente:
		upgrades_atuais[upgrade.id] = {
			"resource": upgrade,
			"quantidade": 1
		}
	else:
		upgrades_atuais[upgrade.id]["quantidade"] += 1

	print(upgrades_atuais)
	
func on_upgrade_selecionado(upgrade: UpgradeAbilidade) -> void:
	aplicar_upgrade(upgrade)
