extends CanvasLayer
class_name MenuPrincipal

@onready var label_versao: Label = %LabelVersao

var menu_opcoes = preload("res://scenes/ui/menu_opcoes.tscn")

func _ready() -> void:
	label_versao.text = ProjectSettings.get_setting("application/config/version")


func _on_botao_jogar_pressed() -> void:
	TransicaoTela.transicao_para_cena("res://scenes/ui/menu_ajuda.tscn")


func _on_botao_upgrades_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	get_tree().change_scene_to_file("res://scenes/ui/menu_meta_upgrades.tscn")


func _on_botao_opcoes_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	var instancia_menu_opcoes = menu_opcoes.instantiate() as MenuOpcoes
	
	add_child(instancia_menu_opcoes)
	
	instancia_menu_opcoes.voltar_pressionado.connect(_on_botao_voltar_pressionado.bind(instancia_menu_opcoes))


func _on_botao_voltar_pressionado(instancia_menu_opcoes: Node) -> void:
	instancia_menu_opcoes.queue_free()
	

func _on_botao_sair_pressed() -> void:
	get_tree().quit()
