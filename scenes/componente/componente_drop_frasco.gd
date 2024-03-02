extends Node
class_name ComponenteDropFrasco

@export_range(0, 100) var chance_drop: float = 50.0
@export var cena_frasco: PackedScene
@export var componente_vida: ComponenteVida

func _ready() -> void:
	componente_vida.morreu.connect(on_morreu)
	
func on_morreu() -> void:
	if cena_frasco == null:
		push_error("Nenhuma cena de frasco definida!")
		
	if not owner is Node2D:
		push_error("Owner deve ser do tipo Node2D!")
		
	var posicao_spawn = (owner as Node2D).global_position
	
	var chance_drop_frasco = randf_range(0, 100)
	
	if not chance_drop_frasco <= chance_drop:
		return
	
	var instancia_frasco = cena_frasco.instantiate() as FrascoExperiencia
	
	owner.add_sibling(instancia_frasco)
	instancia_frasco.global_position = posicao_spawn
