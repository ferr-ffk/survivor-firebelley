extends Node

const RAIO_SPAWN = 370

@export var inimigo_basico_cena: PackedScene
@export var delay_spawn: float = 1.5

@onready var timer_delay_spawn = $Timer
@onready var node_entidades: Node2D = get_tree().get_first_node_in_group("camada_entidades")

@onready var tempo_delay_base: float = timer_delay_spawn.wait_time

func _ready() -> void:
	timer_delay_spawn.wait_time = delay_spawn
	
	if node_entidades == null:
		push_error("Camada de entidades fornecida incorretamente!")


func _on_timer_timeout() -> void:
	timer_delay_spawn.start()
	
	var player: Node2D = get_tree().get_first_node_in_group("player")
	
	if player == null:
		push_error("Nenhum jogador no grupo player!")
		return
		
	var direcao = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# obtem um ponto de spawn em um círculo fora do alcanc da câmera ao redor do jogador
	var posicao_spawn = player.global_position + (direcao * RAIO_SPAWN)
	
	var inimigo = inimigo_basico_cena.instantiate()
	
	node_entidades.add_child(inimigo)
	inimigo.global_position = posicao_spawn


func _on_gerenciador_tempo_arena_dificuldade_arena_alterada(arena_dificuldade: int) -> void:
	# cinco segundos por minuto, 0.1 a mais a cada cinco segundos
	var tempo_atualizacao = (0.1 / 12) * arena_dificuldade
	
	# poe um limite minimo de 0.4s para spawn de novos inimigos
	timer_delay_spawn.wait_time = min(tempo_delay_base - tempo_atualizacao, 0.3)
		
	print(tempo_atualizacao)
	
