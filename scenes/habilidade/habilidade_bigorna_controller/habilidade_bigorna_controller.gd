extends Node
class_name HabilidadeBigornaController

@export var alcance_maximo: int = 150
@export var dano_base: float = 40.0
@export var intervalo_ataque: float = 5

@onready var camada_primeiro_plano = get_tree().get_first_node_in_group("primeiro_plano")

var habilidade_bigorna_cena = preload("res://scenes/habilidade/habilidade_bigorna/habilidade_bigorna.tscn")

func _ready() -> void:
	$Timer.wait_time = intervalo_ataque

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
	
	var bigorna: HabilidadeBigorna = habilidade_bigorna_cena.instantiate()
	camada_primeiro_plano.add_child(bigorna)
	bigorna.componente_hit_box.dano = dano_base
	
	bigorna.global_position = inimigos[0].global_position
