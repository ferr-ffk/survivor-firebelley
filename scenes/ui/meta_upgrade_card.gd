extends PanelContainer
class_name MetaUpgradeCard

@onready var nome: Label = %Nome
@onready var descricao: Label = %Descricao
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var botao_comprar: Button = %BotaoComprar
@onready var label_progresso: Label = %LabelProgresso

var upgrade_card: MetaUpgrade

func set_meta_upgrade_abilidade(upgrade: MetaUpgrade) -> void:
	upgrade_card = upgrade
	
	nome.text = upgrade.titulo
	descricao.text = upgrade.descricao
	
	atualizar_progresso()


func atualizar_progresso() -> void:
	var financa_atual = ProgressaoMeta.dados_salvos["financas_meta_upgrade"]
	
	var porcentagem = financa_atual / upgrade_card.custo_experiencia
	
	porcentagem = min(porcentagem, 1)
	
	progress_bar.value = porcentagem
	
	botao_comprar.disabled = porcentagem < 1
	
	label_progresso.text = str(financa_atual) + "/" + str(upgrade_card.custo_experiencia)


func selecionar_card() -> void:
	animation_player.play("selecionado")
	

func _on_botao_comprar_pressed() -> void:
	if upgrade_card == null:
		return
	
	ProgressaoMeta.adicionar_upgrade_meta(upgrade_card)
	ProgressaoMeta.dados_salvos["financas_meta_upgrade"] -= upgrade_card.custo_experiencia
	ProgressaoMeta.adicionar_upgrade_meta(upgrade_card)
	
	get_tree().call_group("meta_card_upgrade", "atualizar_progresso")
	
	animation_player.play("selecionado")
	
