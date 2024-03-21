extends Area2D
class_name ComponenteHurtBox

@export var componente_vida: ComponenteVida


func _on_area_entered(area: Area2D) -> void:
	# se for uma area2d de vida, não fazer nada
	if not area is ComponenteHitBox:
		return

	print("entrou")

	if componente_vida == null:
		push_error("O componente de vida não pode ser nulo")

	var componente_hit_box: ComponenteHitBox = area
	
	
	componente_vida.dano(componente_hit_box.dano)
	print(componente_vida.vida_atual)
