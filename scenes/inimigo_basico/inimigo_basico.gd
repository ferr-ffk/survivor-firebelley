extends CharacterBody2D

const VELOCIDADE_MAXIMA = 75

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var direction = get_direcao_para_jogador()
	
	velocity = direction * VELOCIDADE_MAXIMA
	
	move_and_slide()
	

func get_direcao_para_jogador() -> Vector2:
	var jogador: CharacterBody2D = get_tree().get_first_node_in_group("player")
	
	if !jogador:
		push_error("Nenhum jogador no grupo player!")
	
	return (jogador.global_position - global_position).normalized()
