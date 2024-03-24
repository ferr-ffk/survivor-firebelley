extends Node2D
class_name TextoFlutuante

@onready var dano: Label = $Dano

func _ready() -> void:
	pass
	
	
func inicio(texto: String) -> void:
	set_texto(texto)
	
	var tween = create_tween()
	tween.set_parallel()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
		
	tween.chain()
	
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
		
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)

	tween.chain()

	tween.tween_callback(queue_free)
	
	var tween_scale = create_tween()
	
	tween_scale.tween_property(self, "scale", Vector2.ONE * 1.5, 0.15)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
		
	tween_scale.tween_property(self, "scale", Vector2.ONE, 0.15)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)

func set_texto(texto: String) -> void:
	dano.text = texto
