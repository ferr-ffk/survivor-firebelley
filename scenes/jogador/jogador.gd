extends CharacterBody2D

const VELOCIDADE_MAXIMA: float = 160.0
const ACELERACAO = 20

func _process(delta) -> void:
	var direcao: Vector2 = get_vetor_movimento().normalized()
	
	var velocidade_alvo = direcao * VELOCIDADE_MAXIMA
	
	# lerp é usado para alcançar uma velocidade em um tempo dado
	velocity = velocity.lerp(velocidade_alvo, 1 - exp(-delta * ACELERACAO))
	
	move_and_slide()


func get_vetor_movimento() -> Vector2:
	var movimento_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movimento_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(movimento_x, movimento_y)
	
