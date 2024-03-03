extends CanvasLayer

@export var gerenciador_experiencia: GerenciadorExperiencia

@onready var barra_vida: ProgressBar = $MarginContainer/BarraVida

func _ready() -> void:
	barra_vida.value = 0
	barra_vida.max_value = gerenciador_experiencia.experiencia_maxima

	gerenciador_experiencia.experiencia_atualizada.connect(on_experiencia_atualizada)	

func on_experiencia_atualizada(experiencia_atual: float, experiencia_maxima: float) -> void:
	#var porcentagem = experiencia_atual / experiencia_maxima
	barra_vida.value = experiencia_atual
