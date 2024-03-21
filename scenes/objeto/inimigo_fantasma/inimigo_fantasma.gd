extends CharacterBody2D
class_name InimigoFantasma

@onready var componente_velocidade: ComponenteVelocidade = $ComponenteVelocidade
@onready var visual: Node2D = $Visual

@export_range(0, 100) var dano: int = 2

func _process(delta: float) -> void:
	componente_velocidade.acelerar_em_player()
	componente_velocidade.mover(self)
	
	var direcao_movimento = sign(velocity.x)
	
	visual.scale = Vector2(direcao_movimento, 1)
	
