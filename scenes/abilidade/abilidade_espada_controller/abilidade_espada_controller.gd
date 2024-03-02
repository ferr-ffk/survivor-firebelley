extends Node

@export var cena_espada: PackedScene
@export var alcance_maximo = 150

@onready var timer = $Timer
@export var dano: float = 25.0


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
	player.get_parent().add_child(espada)
	espada.componente_hit_box.dano = self.dano
	
	espada.global_position = inimigos[0].global_position
	
	# da uma rotação aleatória ao vetor
	espada.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var posicao_inimigo = inimigos[0].global_position - espada.global_position
	espada.rotation = posicao_inimigo.angle()
