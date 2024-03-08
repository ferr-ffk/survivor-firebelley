extends CanvasLayer

@export var arena_tempo_gerenciador: TempoArenaGerenciador

@onready var label_tempo_restante: Label = %TempoRestante

func _process(delta: float) -> void:
	if arena_tempo_gerenciador == null:
		push_error("Gerenciador de tempo de arena é nulo!")
		return
	
	var tempo: float = arena_tempo_gerenciador.get_tempo_restante()
	
	label_tempo_restante.text = format_segundos_para_string(tempo)

func format_segundos_para_string(segundos: float) -> String:
	var minutos = floor(segundos / 60)
	var segundos_restante = segundos - (minutos * 60)
	
	var string = "%02d:" % minutos
	string += "%02d"
	var format_string = string % floor(segundos_restante)
	
	return format_string

