extends Node2D
class_name HabilidadeMachado

const RAIO_MAXIMO: float = 100

@onready var componente_hitbox = $ComponenteHitBox as ComponenteHitBox

var rotacao_base: Vector2 = Vector2.RIGHT

func _ready() -> void:
	rotacao_base = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# o tween serve como um AnimationPlayer só que em código
	var tween = create_tween()
	
	# passa o metodo para ser chamado enquanto o tween executa,
	# com o parâmetro sendo um número entre 0 e 2, neste caso
	tween.tween_method(metodo_tween, 0.0, 2.0, 3)
	
	# ação quando o tween termina
	tween.tween_callback(queue_free)
	
	
func metodo_tween(rotacao: float) -> void:
	var porcentagem = (rotacao / 2)
	var raio = porcentagem * RAIO_MAXIMO
	
	# com o número do tween, obtem a rotacao
	var direcao = rotacao_base.rotated(rotacao * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# se não há nenhum player, para o movimento do machado
	if player == null:
		return
	
	# em suma, a animação completa é de um espiral que inicia na posição do player e termina no	
	# raio maximo
	self.global_position = player.global_position + (direcao * raio)
	
	
