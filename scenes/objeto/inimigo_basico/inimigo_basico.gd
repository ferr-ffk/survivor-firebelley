extends CharacterBody2D

@onready var componente_vida: ComponenteVida = $ComponenteVida

const VELOCIDADE_MAXIMA = 50

func _process(delta: float) -> void:
	var direction = get_direcao_para_jogador()
	
	velocity = direction * VELOCIDADE_MAXIMA
	
	move_and_slide()
	

func get_direcao_para_jogador() -> Vector2:
	var jogador: CharacterBody2D = get_tree().get_first_node_in_group("player")
	
	if !jogador:
		push_error("Nenhum jogador no grupo player!")
	
	return (jogador.global_position - global_position).normalized()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	componente_vida.dano(5)
