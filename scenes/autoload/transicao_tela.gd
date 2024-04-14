extends CanvasLayer

# para sinalizar a outros nodes que a tela está totalmente coberta
signal metade_transicao_alcancada

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var pular_emicao = false

func transicao() -> void:
	animation_player.play("padrao")
	
	await metade_transicao_alcancada
	
	pular_emicao = true
	
	emitir_metade_transicao_alcancada()
	
	animation_player.play_backwards("padrao")
	
 	

func emitir_metade_transicao_alcancada() -> void:
	if pular_emicao:
		pular_emicao = false
		return
	
	metade_transicao_alcancada.emit()
	
