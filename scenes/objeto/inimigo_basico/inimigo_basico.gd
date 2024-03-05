extends CharacterBody2D
class_name InimigoBasico


@onready var componente_vida: ComponenteVida = $ComponenteVida
@export_range(0, 100) var dano: int = 2.0

const VELOCIDADE_MAXIMA = 50


func _process(delta: float) -> void:
	var direction = get_direcao_para_jogador()
	
	velocity = direction * VELOCIDADE_MAXIMA
	
	move_and_slide()


func get_direcao_para_jogador() -> Vector2:
	var jogador: CharacterBody2D = get_tree().get_first_node_in_group("player")
	
	if jogador == null:
		push_error("Nenhum jogador no grupo player!")
		return Vector2.ZERO
	
	return (jogador.global_position - global_position).normalized()

