extends CanvasLayer
class_name Vinheta

func _ready() -> void:
	EventosJogo.jogador_atingido.connect(on_jogador_atingido)
	
	
func on_jogador_atingido() -> void:
	$AnimationPlayer.play("atingido")
