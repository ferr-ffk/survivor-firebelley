extends CharacterBody2D
class_name InimigoBasico

const VELOCIDADE_MAXIMA = 50

@onready var componente_vida: ComponenteVida = $ComponenteVida
@onready var componente_velocidade: ComponenteVelocidade = $ComponenteVelocidade
@onready var visual: Node2D = $Visual
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export_range(0, 100) var dano: int = 2


func _process(delta: float) -> void:
	componente_velocidade.acelerar_em_player()
	componente_velocidade.mover(self)
	
	var direcao_movimento = sign(velocity.x)
	
	visual.scale = Vector2(direcao_movimento, 1)
	

func _on_componente_hurt_box_atingido() -> void:
	audio_stream_player_2d.play()
