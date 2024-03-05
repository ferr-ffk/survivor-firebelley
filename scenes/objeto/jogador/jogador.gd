extends CharacterBody2D

@onready var componente_vida = $ComponenteVida
@onready var timer_intervalo_dano = $IntervaloDano

const VELOCIDADE_MAXIMA: float = 160.0
const ACELERACAO = 20

var num_inimigos_colidindo: int 

func _process(delta) -> void:
	var direcao: Vector2 = get_vetor_movimento().normalized()
	
	var velocidade_alvo = direcao * VELOCIDADE_MAXIMA
	
	# lerp é usado para alcançar uma velocidade em um tempo dado
	velocity = velocity.lerp(velocidade_alvo,  1 - exp(-delta * ACELERACAO))

	print(componente_vida.vida_atual)
	move_and_slide()


func get_vetor_movimento() -> Vector2:
	var movimento_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movimento_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(movimento_x, movimento_y)
	
	
func checar_dano(body: InimigoBasico = null) -> void:
	if num_inimigos_colidindo == 0 || not timer_intervalo_dano.is_stopped():
		return
		
	if body == null: 
		return
	
	componente_vida.dano(body.dano)
	timer_intervalo_dano.start()
	

func _on_hurt_box_body_entered(body: InimigoBasico) -> void:
	num_inimigos_colidindo += 1
	checar_dano(body)

 
func _on_hurt_box_body_exited(body: Node2D) -> void:
	num_inimigos_colidindo -= 1


func _on_intervalo_dano_timeout() -> void:
	checar_dano()
