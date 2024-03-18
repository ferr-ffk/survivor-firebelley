extends CharacterBody2D

signal morte

@onready var componente_vida: ComponenteVida = $ComponenteVida
@onready var timer_intervalo_dano: Timer = $IntervaloDano
@onready var barra_vida: ProgressBar = $BarraVida
@onready var habilidades = $Habilidades
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visual: Node2D = $Visual

const VELOCIDADE_MAXIMA: float = 160.0
const ACELERACAO = 20

var num_inimigos_colidindo: int


func _ready() -> void:
	barra_vida.value = componente_vida.get_porcentagem_vida()
	
	EventosJogo.abilidade_adicionada.connect(on_abilidade_adicionada)


func _process(delta) -> void:
	var direcao: Vector2 = get_vetor_movimento().normalized()
	
	var velocidade_alvo = direcao * VELOCIDADE_MAXIMA
	
	# lerp é usado para alcançar uma velocidade em um tempo dado
	velocity = velocity.lerp(velocidade_alvo,  1 - exp(-delta * ACELERACAO))

	move_and_slide()
	
	if direcao.x != 0 || direcao.y != 0:
		animation_player.play("andar")
		
		var direcao_movimento = sign(direcao.x)
		
		# aplica o scale para direcionar o sprite na esquerda ou direita
		if direcao_movimento == 0:
			visual.scale = Vector2.ONE
		else:
			visual.scale = Vector2(direcao_movimento, 1)
	else:
		animation_player.play("RESET")


func get_vetor_movimento() -> Vector2:
	var movimento_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movimento_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(movimento_x, movimento_y)
	
	
# o jogador não deveria receber dano proporcionalmente ao número de inimigos,
# então quando um inimigo entra na area inicia um timer que impede dano adicional de ser causado
func checar_dano(body: InimigoBasico = null) -> void:
	if num_inimigos_colidindo == 0 || not timer_intervalo_dano.is_stopped():
		return
		
	if body == null: 
		return
	
	componente_vida.dano(body.dano)
	timer_intervalo_dano.start()
	

func _on_hurt_box_body_entered(body: InimigoBasico) -> void:
	num_inimigos_colidindo += 1
	checar_dano(body)

 
func _on_hurt_box_body_exited(body: Node2D) -> void:
	num_inimigos_colidindo -= 1


func _on_intervalo_dano_timeout() -> void:
	checar_dano()


func _on_componente_vida_vida_atualizada() -> void:
	barra_vida.value = componente_vida.get_porcentagem_vida()


func _on_componente_vida_morreu() -> void:
	morte.emit()


## como a habilidade não possui método para ser adicionada ao jogador, faremos aqui
func on_abilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeAbilidade) -> void:
	# verifica se é uma habilidade ou upgrade
	if not upgrade is Habilidade:
		return
		
	var habilidade = upgrade as Habilidade
		
	# instancia o gerenciador da habilidade e adiciona no node Habilidades do Jogador
	habilidades.add_child(habilidade.cena_habilidade_controller.instantiate())
