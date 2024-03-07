extends Node
class_name ComponenteVida

signal morreu
signal vida_atualizada

@export var vida_maxima: float = 10.0

@onready var vida_atual = vida_maxima

func dano(qtd_dano: float) -> void:
	vida_atual = max(vida_atual - qtd_dano, 0)
	
	vida_atualizada.emit()
	
	# para monitorar alguma mudança de estado e realizar mudanças no próximo frame livre
	Callable(checar_morreu).call_deferred()

	
func get_porcentagem_vida():
	if vida_maxima <= 0:
		return 0
		
	return min(vida_atual / vida_maxima, 1)


func curar(vida: float) -> void:
	vida_atual = min(vida_atual + vida, vida_maxima)


func checar_morreu() -> void:
	if vida_atual <= 0:
		morreu.emit()
		owner.queue_free()
