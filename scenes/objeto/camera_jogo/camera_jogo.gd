extends Camera2D

var posicao_alvo = Vector2.ZERO
var player: CharacterBody2D

func _ready() -> void:
	# torna esta camera a principal
	make_current()
	
	
func _process(delta: float) -> void:
	obter_alvo()
	global_position = global_position.lerp(posicao_alvo, 1.0 - exp(-delta * 20))
	
	
func obter_alvo() -> void:
	var nodes_player = get_tree().get_nodes_in_group("player")
	
	if nodes_player.size() == 0:
		push_error("Nenhum jogador no grupo player!")
		
	player = nodes_player[0]
	
	posicao_alvo = player.global_position
