extends Node
class_name ComponenteHitFlash

# por conta da referência do mesmo shader por todas as instâncias, se uma for atualizada, todas serão
# para resolver isso o hit_flash_material não pode ser obtido do preload(), e sim de um @export
# isso 
@export var hit_flash_material: ShaderMaterial
@export var componente_vida: ComponenteVida
@export var sprite: Sprite2D

var hit_flash_tween: Tween


func _ready() -> void:
	componente_vida.vida_atualizada.connect(on_vida_atualizada)
	
	sprite.material = hit_flash_material
	
	
func on_vida_atualizada() -> void:
	# se já possui um tween rodando, invalida sua execução
	if hit_flash_tween != null and hit_flash_tween.is_valid():
		hit_flash_tween.kill()
	
	# altera o uniform float declarado no shader
	(sprite.material as ShaderMaterial).set_shader_parameter("porcentagem_lerp", 1.0)
	
	hit_flash_tween = create_tween()
	
	# anima a propriedade até que seja 0.0
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/porcentagem_lerp", 0.0, 0.3)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
	
	
