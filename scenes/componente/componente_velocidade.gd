extends Node
class_name ComponenteVelocidade

@export var velocidade_maxima: int = 40
@export var aceleracao: float = 5

var velocidade: Vector2 = Vector2.ZERO

func acelerar_em_player() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	var owner_2d = owner as Node2D
	
	if owner_2d == null or player == null:
		return

	var direcao = (player.global_position - owner_2d.global_position).normalized()
	
	acelerar_em_direcao(direcao)
	

func acelerar_em_direcao(direcao: Vector2) -> void:
	var velocidade_alvo: Vector2 = direcao * velocidade_maxima
	
	# valor para suavizar a acelaração
	var valor_aceleracao: float = 1 - exp(-aceleracao * get_process_delta_time())
	
	velocidade = velocidade.lerp(velocidade_alvo, valor_aceleracao)


func mover(character: CharacterBody2D) -> void:
	character.velocity = velocidade
	
	character.move_and_slide()
	
	velocidade = character.velocity
	

