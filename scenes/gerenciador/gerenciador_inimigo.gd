extends Node

const RAIO_SPAWN = 350

@export var inimigo_basico_cena: PackedScene
@export var delay_spawn: float = 1.5

@onready var timer = $Timer


func _ready() -> void:
	timer.wait_time = delay_spawn


func _on_timer_timeout() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player")
	
	if player == null:
		push_error("Nenhum jogador no grupo player!")
		
	var direcao = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# obtem um ponto de spawn em um círculo fora do alcanc da câmera ao redor do jogador
	var posicao_spawn = player.global_position + (direcao * RAIO_SPAWN)
	
	var inimigo = inimigo_basico_cena.instantiate()
	
	get_parent().add_child(inimigo)
	inimigo.global_position = posicao_spawn
