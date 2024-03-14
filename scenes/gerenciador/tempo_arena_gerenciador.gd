extends Node
class_name TempoArenaGerenciador

signal dificuldade_arena_alterada(arena_dificuldade: int)

const INTERVALO_DIFICULDADE: int = 5

@export var cena_tela_fim: PackedScene
@export var tempo_total: float = 60.0
var arena_dificuldade: float = 0.0

@onready var timer = $Timer


func _ready() -> void:
	timer.wait_time = tempo_total
	timer.start()

	
func _process(delta: float) -> void:
	# calcula o tempo em para que aumenta a dificuldade
	var proximo_tempo_mudanca_dificuldade = timer.wait_time - ((arena_dificuldade + 1) * INTERVALO_DIFICULDADE)
	
	# para que a cada cinco segundos aumente a dificuldade
	if timer.time_left <= proximo_tempo_mudanca_dificuldade:
		arena_dificuldade += 1
		dificuldade_arena_alterada.emit(arena_dificuldade)
	

func get_tempo_restante() -> float:
	return timer.time_left


func _on_timer_timeout() -> void:
	var tela_vitoria = cena_tela_fim.instantiate()
	
	owner.add_child(tela_vitoria)
