extends CharacterBody2D

signal morte

@onready var componente_velocidade: ComponenteVelocidade = $ComponenteVelocidade
@onready var componente_vida: ComponenteVida = $ComponenteVida
@onready var timer_intervalo_dano: Timer = $IntervaloDano
@onready var barra_vida: ProgressBar = $BarraVida
@onready var habilidades = $Habilidades
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visual: Node2D = $Visual
@onready var componente_hit_audio_stream_aleatorio: ComponenteAudioStreamPlayer2DAleatorio = $ComponenteHitAudioStreamAleatorio
@onready var label_vida: Label = %LabelVida

var num_inimigos_colidindo: int

var velocidade_base: float = 0


func _ready() -> void:
	barra_vida.value = componente_vida.get_porcentagem_vida()
	
	velocidade_base = componente_velocidade.velocidade_maxima
	
	EventosJogo.habilidade_adicionada.connect(on_habilidade_adicionada)

	var contagem_upgrade_aumento_vida_maxima: int = ProgressaoMeta.get_contagem_upgrade("vida_maxima")
	
	if contagem_upgrade_aumento_vida_maxima > 0:
		componente_vida.alterar_vida_maxima(componente_vida.vida_maxima + (contagem_upgrade_aumento_vida_maxima * 5))
		
	label_vida.text = str(componente_vida.vida_atual)
		

func _process(delta) -> void:
	var direcao: Vector2 = get_vetor_movimento().normalized()
	
	componente_velocidade.acelerar_em_direcao(direcao)
	componente_velocidade.mover(self)
	
	if direcao.x != 0 || direcao.y != 0:
		animation_player.play("andar")
		
		var direcao_movimento = sign(direcao.x)
		
		# aplica o scale para direcionar o sprite na esquerda ou direita
		if direcao_movimento != 0:
			visual.scale = Vector2(direcao_movimento, 1)
	else:
		animation_player.play("RESET")


func get_vetor_movimento() -> Vector2:
	var movimento_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movimento_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(movimento_x, movimento_y)
	
	
# o jogador não deveria receber dano proporcionalmente ao número de inimigos,
# então quando um inimigo entra na area inicia um timer que impede dano adicional de ser causado
func checar_dano(body: Node2D = null) -> void:
	if num_inimigos_colidindo == 0 || not timer_intervalo_dano.is_stopped():
		return
		
	if body == null: 
		return
	
	componente_vida.dano(body.dano)
	timer_intervalo_dano.start()
	

func _on_hurt_box_body_entered(body: Node2D) -> void:
	num_inimigos_colidindo += 1
	checar_dano(body)

 
func _on_hurt_box_body_exited(body: Node2D) -> void:
	num_inimigos_colidindo -= 1


func _on_intervalo_dano_timeout() -> void:
	checar_dano()


func _on_componente_vida_vida_atualizada() -> void:
	componente_hit_audio_stream_aleatorio.play_aleatorio()
	
	EventosJogo.emitir_jogador_atingido()
	barra_vida.value = componente_vida.get_porcentagem_vida()
	
	label_vida.text = str(componente_vida.vida_atual)


func _on_componente_vida_morreu() -> void:
	morte.emit()


## como a habilidade não possui método para ser adicionada ao jogador, faremos aqui
func on_habilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeHabilidade) -> void:
	# verifica se é uma habilidade
	if upgrade is Habilidade:
		var habilidade = upgrade as Habilidade
			
		# instancia o gerenciador da habilidade e adiciona no node Habilidades do Jogador
		habilidades.add_child(habilidade.cena_habilidade_controller.instantiate())

	if upgrade.id == "velocidade_jogador":
		var aumento_velocidade = 0.1 * upgrades_atuais["velocidade_jogador"]["quantidade"] * velocidade_base
		
		velocidade_base = min(velocidade_base + aumento_velocidade, 175)
		
		componente_velocidade.velocidade_maxima = velocidade_base
