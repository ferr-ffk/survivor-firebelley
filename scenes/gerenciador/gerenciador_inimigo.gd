extends Node

# o bitshift serve para fornecer a camada de colisão diretamente
const LAYER_COLISAO = 1 << 0
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


func get_posicao_spawn() -> Vector2:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return Vector2.ZERO
	
	var posicao_spawn: Vector2 = Vector2.ZERO
	var direcao = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	
	for i in 4:
		# obtem um ponto de spawn em um círculo fora do alcanc da câmera ao redor do jogador
		posicao_spawn = player.global_position + (direcao * RAIO_SPAWN)
		
		# cria os parametros do raycast
		# verifica se o spawn colide com a camada de colisão de terreno
		var parametros_query = PhysicsRayQueryParameters2D.create(player.global_position, posicao_spawn, LAYER_COLISAO)	
		
		# aplica os parametros
		var resultado: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(parametros_query)
	
		# em caso de colisão, a posição sera rodada 90 graus, até que não esteja em conflito
		# há apenas 4 iterações, já que mais que é desnecessário
		var existeColisao: bool = resultado.is_empty()
		
		if existeColisao:
			break
		else:
			direcao = direcao.rotated(deg_to_rad(90))
	
	return posicao_spawn
	
	
func _on_timer_timeout() -> void:
	timer_delay_spawn.start()
	
	var player: Node2D = get_tree().get_first_node_in_group("player")
	
	if player == null:
		return
		
	var inimigo = inimigo_basico_cena.instantiate()
	
	node_entidades.add_child(inimigo)
	inimigo.global_position = get_posicao_spawn()


func _on_gerenciador_tempo_arena_dificuldade_arena_alterada(arena_dificuldade: int) -> void:
	# cinco segundos por minuto, 0.1 a mais a cada cinco segundos
	var tempo_atualizacao = (0.1 / 12) * arena_dificuldade
	
	# poe um limite minimo de 0.4s para spawn de novos inimigos
	timer_delay_spawn.wait_time = min(tempo_delay_base - tempo_atualizacao, 0.3)
		
	print(tempo_atualizacao)
	
