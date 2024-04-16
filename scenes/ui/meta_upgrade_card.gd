extends PanelContainer
class_name MetaUpgradeCard

@onready var nome: Label = %Nome
@onready var descricao: Label = %Descricao
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var botao_comprar: Button = %BotaoComprar
@onready var label_progresso: Label = %LabelProgresso
@onready var label_conta: Label = %LabelConta

var upgrade_card: MetaUpgrade


func set_meta_upgrade_abilidade(upgrade: MetaUpgrade) -> void:
	upgrade_card = upgrade
	
	nome.text = upgrade.titulo
	descricao.text = upgrade.descricao
	
	atualizar_progresso()


func atualizar_progresso() -> void:
	var quantidade_atual = 0
	
	# o jogo da crash se o upgrade não existe e é referenciado um campo dele
	if ProgressaoMeta.dados_salvos["upgrades_meta"].has(upgrade_card.id):
		quantidade_atual = ProgressaoMeta.dados_salvos["upgrades_meta"][upgrade_card.id]["quantidade"]
	
	var financa_atual = ProgressaoMeta.dados_salvos["financas_meta_upgrade"]
	
	var porcentagem = financa_atual / upgrade_card.custo_experiencia
	
	porcentagem = min(porcentagem, 1)
	progress_bar.value = porcentagem
	label_progresso.text = str(financa_atual) + "/" + str(upgrade_card.custo_experiencia)
	
	var experiencia_insuficiente = porcentagem < 1
	var quantidade_maxima_atingida = quantidade_atual >= upgrade_card.quantidade_maxima
	
	botao_comprar.disabled = experiencia_insuficiente || quantidade_maxima_atingida
	
	if quantidade_maxima_atingida:
		botao_comprar.text = "Maximizado"
	
	label_conta.text = "x%d" % quantidade_atual + "(%d)" % upgrade_card.quantidade_maxima


func selecionar_card() -> void:
	animation_player.play("selecionado")
	

func _on_botao_comprar_pressed() -> void:
	if upgrade_card == null:
		return
	
	ProgressaoMeta.adicionar_upgrade_meta(upgrade_card)
	ProgressaoMeta.dados_salvos["financas_meta_upgrade"] -= upgrade_card.custo_experiencia
	ProgressaoMeta.salvar()
	
	# avisa a todos os cards no menu para atualizar a contagem do dinheiroO
	get_tree().call_group("meta_card_upgrade", "atualizar_progresso")
	
	selecionar_card()
	
