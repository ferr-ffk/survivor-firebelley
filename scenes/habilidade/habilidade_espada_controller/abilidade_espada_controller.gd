extends Node

const AUMENTO_DANO_HABILIDADE: float = 1.125

@export var cena_espada: PackedScene
@export var alcance_maximo = 150

@export var dano: float = 25.0
@export var duracao_ataque: float = 1.5

@onready var timer = $Timer

@onready var camada_primeiro_plano = get_tree().get_first_node_in_group("primeiro_plano")

func _ready() -> void:
	EventosJogo.abilidade_adicionada.connect(on_abilidade_adicionada)
	timer.wait_time = duracao_ataque

func _on_timer_timeout() -> void:
	var inimigos: Array = get_tree().get_nodes_in_group("enemies")
	var player: Node2D = get_tree().get_first_node_in_group("player")

	if player == null:
		push_error("Nenhum jogador no grupo player!")
	
	# filtra todos os inimigos que sua distância ao quadrado até o player é maior que o alcance máximo ao quadrado
	inimigos = inimigos.filter(func(inimigo: Node2D): 
		return inimigo.global_position.distance_squared_to(player.global_position) < pow(alcance_maximo, 2)
	)
	
	if inimigos.size() == 0:
		return
	
	# ordena os inimigos em ordem crescente de distancia
	inimigos.sort_custom(func(a: Node2D, b: Node2D):
		var a_distancia = a.global_position.distance_squared_to(player.global_position)
		var b_distancia = b.global_position.distance_squared_to(player.global_position)
		
		return a_distancia < b_distancia
	)
	
	var espada: AbilidadeEspada = cena_espada.instantiate()
	camada_primeiro_plano.add_child(espada)
	espada.componente_hit_box.dano = self.dano
	
	espada.global_position = inimigos[0].global_position
	
	# da uma rotação aleatória ao vetor
	espada.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var posicao_inimigo = inimigos[0].global_position - espada.global_position
	espada.rotation = posicao_inimigo.angle()
	
func on_abilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeAbilidade, ) -> void:
	if upgrade.id != "espada_rate":
		return
	
	# checa o nível da abilidade, e adiciona 10% a cada nível
	var porcentagem_reducao = upgrades_atuais["espada_rate"]["quantidade"] * 0.1
	
	timer.wait_time = duracao_ataque * (1 - porcentagem_reducao)
	
	# coloca um limite de 0.75s de duração mínima 
	timer.wait_time = max(timer.wait_time, 0.75)
	
	# restart necessário após alteração no wait_time
	timer.start()
