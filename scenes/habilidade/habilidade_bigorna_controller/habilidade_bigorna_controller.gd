extends Node
class_name HabilidadeBigornaController

@export var alcance_maximo: int = 70
@export var dano_base: float = 40.0
@export var intervalo_ataque: float = 5

@onready var camada_primeiro_plano = get_tree().get_first_node_in_group("primeiro_plano")

var habilidade_bigorna_cena = preload("res://scenes/habilidade/habilidade_bigorna/habilidade_bigorna.tscn")

var contagem_bigornas: int = 0

func _ready() -> void:
	$Timer.wait_time = intervalo_ataque

	EventosJogo.habilidade_adicionada.connect(_on_habilidade_adicionada)
	
	
func _on_habilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeHabilidade) -> void:
	if upgrade.id == "quantidade_bigorna":
		contagem_bigornas = upgrades_atuais["quantidade_bigorna"]["quantidade"]


func _on_timer_timeout() -> void:
	var inimigos: Array = get_tree().get_nodes_in_group("enemies") as Array
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D

	if player == null:
		push_error("Nenhum jogador no grupo player!")
	
	var direcao = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var posicao_spawn = player.global_position + (direcao * randf_range(0, alcance_maximo))
	
	var parametro_query = PhysicsRayQueryParameters2D.create(player.global_position, posicao_spawn)
	
	var resultado = get_tree().root.world_2d.direct_space_state.intersect_ray(parametro_query)
	
	if !resultado.is_empty():
		posicao_spawn = resultado["position"]
		
	var bigorna = habilidade_bigorna_cena.instantiate() as HabilidadeBigorna
	
	get_tree().get_first_node_in_group("primeiro_plano").add_child(bigorna)
	bigorna.global_position = posicao_spawn
	bigorna.componente_hit_box.dano = dano_base
