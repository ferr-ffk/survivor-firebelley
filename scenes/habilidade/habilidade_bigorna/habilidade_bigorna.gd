extends Node2D
class_name HabilidadeBigorna

@onready var componente_hit_box: ComponenteHitBox = $ComponenteHitBox

func _ready() -> void:
	EventosJogo.habilidade_adicionada.connect(_on_habilidade_adicionada)
	
func _on_habilidade_adicionada(upgrade: UpgradeHabilidade) -> void:
	pass
