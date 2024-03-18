extends CharacterBody2D
class_name InimigoBasico

const VELOCIDADE_MAXIMA = 50

@onready var componente_vida: ComponenteVida = $ComponenteVida
@onready var visual: Node2D = $Visual

@export_range(0, 100) var dano: int = 2


func _process(delta: float) -> void:
	var direcao = get_direcao_para_jogador()
	
	velocity = direcao * VELOCIDADE_MAXIMA
	
	var direcao_movimento = sign(direcao.x)
	
	visual.scale = Vector2(direcao_movimento, 1)
	
	move_and_slide()
	
	
func get_direcao_para_jogador() -> Vector2:
	var jogador: CharacterBody2D = get_tree().get_first_node_in_group("player")
	
	if jogador == null:
		push_error("Nenhum jogador no grupo player!")
		return Vector2.ZERO
	
	return (jogador.global_position - global_position).normalized()

