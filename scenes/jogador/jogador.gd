extends CharacterBody2D

const VELOCIDADE_MAXIMA: float = 200.0

func _ready() -> void:
	pass

func _process(delta) -> void:
	var direcao: Vector2 = get_vetor_movimento().normalized()
	
	velocity = direcao * VELOCIDADE_MAXIMA
	
	move_and_slide()

func get_vetor_movimento() -> Vector2:
	var vetor_movimento = Vector2.ZERO
	
	var movimento_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movimento_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(movimento_x, movimento_y)
	
