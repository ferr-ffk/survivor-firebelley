extends Node2D
class_name FrascoExperiencia

@onready var collision_shape_2d: CollisionShape2D = $AreaColetaJogador/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

@export var experiencia: int = 2


func tween_coletar(porcentagem: float, inicio: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null:
		return
	
	global_position = inicio.lerp(player.global_position, porcentagem)
	
	var direcao_do_inicio = player.global_position - inicio
	
	var rotacao_alvo = direcao_do_inicio.angle() - deg_to_rad(90)
	
	rotation = lerp_angle(
		rotation,
		rotacao_alvo,
		1 - exp(-2 * get_process_delta_time())
	)
	
	
func coletar() -> void:
	EventosJogo.emitir_frasco_experiencia_coletado(experiencia)
	queue_free()
	

func desabilitar_colisao() -> void:
	collision_shape_2d.disabled = true	
	
	
func _on_area_coleta_jogador_area_entered(area: Area2D) -> void:
	Callable(desabilitar_colisao).call_deferred()
	
	var tween = create_tween()
	# quando parallel for verdadeiro, todos os tweens criados serão realizados ao mesmo tempo
	tween.set_parallel()
	
	tween.tween_method(tween_coletar.bind(self.global_position), 0.0, 1.0, 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.05).set_delay(0.45)
	
	# espera todos os tweens criados até agora terminarem para realizar o proximo
	tween.chain()
		
	tween.tween_callback(coletar)
	
