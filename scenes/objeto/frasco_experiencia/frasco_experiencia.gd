extends Node


func _ready() -> void:
	pass # Replace with function body.


func _on_area_coleta_jogador_area_entered(area: Area2D) -> void:
	queue_free()
