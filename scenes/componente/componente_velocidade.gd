extends Node
class_name ComponenteVelocidade

@export var velocidade_maxima: int = 40
@export var aceleracao: float = 5

var velocidade: Vector2 = Vector2.ZERO

func acelerar_em_player() -> void:
	pass


func acelerar_em_direcao(direcao: Vector2) -> void:
	var velocidade_alvo: Vector2 = direcao * velocidade
	
	# valor para suavizar a acelaração
	var valor_aceleracao: float = 1 - exp(-aceleracao * get_process_delta_time())
	
	velocidade = velocidade.lerp(velocidade_alvo, valor_aceleracao)


func mover(character: CharacterBody2D) -> void:
	pass
	

