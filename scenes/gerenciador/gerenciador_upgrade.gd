extends Node
class_name GerenciadorUpgrade

const NUMERO_UPGRADES_PARA_ESCHOLER: int = 2

@export var upgrades_disponiveis: Array[UpgradeAbilidade]
@export var gerenciador_experiencia: GerenciadorExperiencia
@export var tela_upgrade_cena: PackedScene

var upgrades_atuais: Dictionary = {}

func _ready() -> void:
	gerenciador_experiencia.nivel_upgrade.connect(on_nivel_upgrade)


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
	
	if upgrade.nivel_maximo > 0:
		var nivel_atual = upgrades_atuais[upgrade.id]["quantidade"]
		
		# filtra os upgrades disponiveis removendo o que já está no nivel maximo
		if upgrade.nivel_maximo == nivel_atual:
			upgrades_disponiveis = upgrades_disponiveis.filter(func(upgrade_disponivel): 
				return upgrade_disponivel.id != upgrade.id
			)
		
		
	print(upgrades_atuais)
	
	EventosJogo.emitir_abilidade_adicionada(upgrades_atuais, upgrade)

	
func on_upgrade_selecionado(upgrade: UpgradeAbilidade) -> void:
	aplicar_upgrade(upgrade)


## Retorna o array dos upgrades escolhidos
func obter_upgrades() -> Array[UpgradeAbilidade]:
	var upgrades_escolhidos: Array[UpgradeAbilidade] = []
	
	var upgrades_filtrados: Array[UpgradeAbilidade] = upgrades_disponiveis.duplicate()
	
	for i in NUMERO_UPGRADES_PARA_ESCHOLER:
		var upgrade_escolhido: UpgradeAbilidade = upgrades_filtrados.pick_random()
		
		# se não tem mais upgrades a escolher, quebra o loop
		if upgrades_escolhidos.size() == 0:
			break
		
		upgrades_escolhidos.append(upgrade_escolhido)
		
		# filtra os upgrades dos escolhidos com o upgrade escolhido
		upgrades_filtrados = upgrades_filtrados.filter(func(upgrade: UpgradeAbilidade): return upgrade.id != upgrade_escolhido.id)
	
	return upgrades_escolhidos


## A tela de upgrade é instanciada quando o nivel muda, de acordo com o sinal do GerenciadorUpgrade
##  
## Ela mostra os upgrades disponiveis da variavel de export em forma de Card
## O Card irá escutar algum evento de click nele, se for chamado ele envia o sinal para a tela
## A tela emite esse sinal para o gerenciador de upgrade
## O gerenciador, por fim, atualiza os upgrades do jogador com o upgrade fornecido
func on_nivel_upgrade(nivel_atual: int) -> void:
	var tela_upgrade_instancia: TelaUpgrade = tela_upgrade_cena.instantiate()
	add_child(tela_upgrade_instancia)

	var upgrades_escolhidos: Array[UpgradeAbilidade] = obter_upgrades()
	
	tela_upgrade_instancia.set_upgrade_abilidade(upgrades_escolhidos)
	
	tela_upgrade_instancia.upgrade_selecionado.connect(on_upgrade_selecionado)
