extends Node
class_name GerenciadorUpgrade

const NUMERO_UPGRADES_PARA_ESCOLHER: int = 2

@export var gerenciador_experiencia: GerenciadorExperiencia
@export var tela_upgrade_cena: PackedScene

var upgrades_atuais: Dictionary = {}

var upgrades_disponiveis: WeightedTable = WeightedTable.new()

var machado_upgrade: UpgradeHabilidade = preload("res://resources/upgrades/machado.tres")
var bigorna_upgrade: UpgradeHabilidade = preload("res://resources/upgrades/bigorna.tres")
var machado_dano_upgrade: UpgradeHabilidade = preload("res://resources/upgrades/machado_dano.tres")
var espada_rate_upgrade: UpgradeHabilidade = preload("res://resources/upgrades/espada_rate.tres")
var espada_dano_upgrade: UpgradeHabilidade = preload("res://resources/upgrades/espada_dano.tres")
var velocidade_jogador = preload("res://resources/upgrades/velocidade_jogador.tres")
var quantidade_bigorna = preload("res://resources/upgrades/quantidade_bigorna.tres")

func _ready() -> void:
	upgrades_disponiveis.add_item(machado_upgrade, 10)
	upgrades_disponiveis.add_item(espada_rate_upgrade, 10)
	upgrades_disponiveis.add_item(espada_dano_upgrade, 10)
	upgrades_disponiveis.add_item(velocidade_jogador, 5)
	upgrades_disponiveis.add_item(bigorna_upgrade, 5)
	
	gerenciador_experiencia.nivel_upgrade.connect(on_nivel_upgrade)


func aplicar_upgrade(upgrade: UpgradeHabilidade) -> void:
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
			upgrades_disponiveis.remove(upgrade)

	# usado para verificar se algum upgrade dependente de outro foi adicionado, e então
	# o adiciona
	atualizar_upgrades_disponiveis(upgrade)
		
	EventosJogo.emitir_habilidade_adicionada(upgrades_atuais, upgrade)


func atualizar_upgrades_disponiveis(upgrade: UpgradeHabilidade) -> void:
	# se o machado foi escolhido, então os upgrades dependentes dele podem ser disponiveis
	if upgrade.id == machado_upgrade.id:
		upgrades_disponiveis.add_item(machado_dano_upgrade, 10)

	# se a bigorna foi adicionada, deixa o upgrade de aumento de bigorna disponivel
	if upgrade.id == bigorna_upgrade.id:
		upgrades_disponiveis.add_item(quantidade_bigorna, 10)
	
	
func on_upgrade_selecionado(upgrade: UpgradeHabilidade) -> void:
	aplicar_upgrade(upgrade)


## Retorna o array dos upgrades escolhidos
func obter_upgrades() -> Array[UpgradeHabilidade]:
	var upgrades_escolhidos: Array[UpgradeHabilidade] = []
	
	#if upgrades_filtrados.is_empty():
		#push_error("Não há nenhum upgrade restante...")
	
	for i in NUMERO_UPGRADES_PARA_ESCOLHER:
		# se não tem mais upgrades a escolher, quebra o loop
		if upgrades_disponiveis.items.size() == upgrades_escolhidos.size():
			break
			
		var upgrade_escolhido: UpgradeHabilidade = upgrades_disponiveis.pick_item(upgrades_escolhidos)
		
		upgrades_escolhidos.append(upgrade_escolhido)
		
	
	return upgrades_escolhidos


## A tela de upgrade é instanciada quando o nivel muda, de acordo com o sinal do GerenciadorUpgrade
##  
## Ela mostra os upgrades disponiveis da variavel de export em forma de Card
## O Card irá escutar algum evento de click nele, se for chamado ele envia o sinal para a tela
## A tela emite esse sinal para o gerenciador de upgrade
## O gerenciador, por fim, atualiza os upgrades do jogador com o upgrade fornecido
func on_nivel_upgrade(nivel_atual: int) -> void:
	var tela_upgrade_instancia = tela_upgrade_cena.instantiate() as TelaUpgrade
	add_child(tela_upgrade_instancia)

	var upgrades_escolhidos: Array[UpgradeHabilidade] = obter_upgrades()
	
	tela_upgrade_instancia.set_upgrade_abilidade(upgrades_escolhidos)
	
	tela_upgrade_instancia.upgrade_selecionado.connect(on_upgrade_selecionado)
