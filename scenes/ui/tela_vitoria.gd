extends CanvasLayer


func _ready() -> void:
	get_tree().paused = true


func _on_jogar_novamente_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/principal/principal.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
