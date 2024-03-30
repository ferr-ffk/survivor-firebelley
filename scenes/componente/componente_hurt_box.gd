extends Area2D
class_name ComponenteHurtBox

@export var componente_vida: ComponenteVida

var texto_flutuante_cena = preload("res://scenes/ui/texto_flutuante.tscn")


func _on_area_entered(area: Area2D) -> void:
	# se for uma area2d de outro tipo, não fazer nada
	if not area is ComponenteHitBox:
		return

	if componente_vida == null:
		push_error("O componente de vida não pode ser nulo")
		return

	var componente_hit_box: ComponenteHitBox = area as ComponenteHitBox	
	
	componente_vida.dano(componente_hit_box.dano)
	
	var texto_flutuante = texto_flutuante_cena.instantiate() as TextoFlutuante
	
	get_tree().get_first_node_in_group("primeiro_plano").add_child(texto_flutuante)
	
	var format_string = "%0.1f"
		
	if round(componente_hit_box.dano) == componente_hit_box.dano:
		format_string = "%0.0f"
		
	texto_flutuante.global_position = global_position + (Vector2.UP * 16)
	texto_flutuante.inicio(format_string % componente_hit_box.dano)
	
