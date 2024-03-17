extends Node
class_name HabilidadeMachadoController

@onready var timer = $Timer

@export var habilidade_machado: PackedScene
@export var dano: float = 10.0
@export var duracao_ataque: float = 4.5


func _ready() -> void:
	timer.wait_time = duracao_ataque


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	var instancia_machado = habilidade_machado.instantiate() as HabilidadeMachado
	
	var primeiro_plano = get_tree().get_first_node_in_group("primeiro_plano") as Node2D
	
	if primeiro_plano == null:
		return
	
	primeiro_plano.add_child(instancia_machado)
	
	instancia_machado.global_position = player.global_position
	
	instancia_machado.componente_hitbox.dano = self.dano
