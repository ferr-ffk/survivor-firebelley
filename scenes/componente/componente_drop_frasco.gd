extends Node
class_name ComponenteDropFrasco

@export_range(0, 100) var chance_drop: float = 60.0
@onready var cena_frasco: PackedScene = load("res://scenes/objeto/frasco_experiencia/frasco_experiencia.tscn")
@export var componente_vida: ComponenteVida

@onready var node_entidades: Node2D = get_tree().get_first_node_in_group("camada_entidades")

func _ready() -> void:
	componente_vida.morreu.connect(on_morreu)
	
	if node_entidades == null:
		push_error("Camada de entidades fornecida incorretamente!")
		
			
func on_morreu() -> void:
	print_debug(chance_drop)
	
	var chance_drop_ajustado = chance_drop
	
	var quantidade_upgrade_ganho_experiencia = ProgressaoMeta.get_contagem_upgrade("ganho_experiencia")
	
	if quantidade_upgrade_ganho_experiencia > 0:
		chance_drop_ajustado += 10
	
	if not owner is Node2D:
		push_error("Owner deve ser do tipo Node2D!")
		
	var posicao_spawn = (owner as Node2D).global_position
	var chance_drop_frasco = randf_range(0, 100)
	
	if not chance_drop_frasco <= chance_drop_ajustado:
		return
	
	var instancia_frasco = cena_frasco.instantiate() as FrascoExperiencia
	
	node_entidades.add_child(instancia_frasco)
	instancia_frasco.global_position = posicao_spawn
	
	print_debug(chance_drop_ajustado)
