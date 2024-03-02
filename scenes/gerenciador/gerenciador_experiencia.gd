extends Node

var experiencia_atual = 0

func aumentar_experiencia(n: int) -> void:
	experiencia_atual += n
	
	print("Experiencia " + str(experiencia_atual))
