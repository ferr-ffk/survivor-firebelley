extends Node
class_name TempoArenaGerenciador

@onready var timer = $Timer


func get_tempo_restante() -> float:
	return timer.wait_time - timer.time_left
