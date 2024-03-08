extends Node
class_name TempoArenaGerenciador

@export var cena_tela_fim: PackedScene

@export var tempo_total: float = 60.0

@onready var timer = $Timer


func _ready() -> void:
	timer.wait_time = tempo_total
	timer.start()


func get_tempo_restante() -> float:
	return timer.time_left


func _on_timer_timeout() -> void:
	var tela_vitoria = cena_tela_fim.instantiate()
	
	owner.add_child(tela_vitoria)
