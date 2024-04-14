extends Node

var dados_salvos: Dictionary = {
	"financas_meta_upgrade": 0,
	"upgrades_meta": {},
}

func _ready() -> void:
	EventosJogo.frasco_experiencia_coletado.connect(_on_frasco_experiencia_coletado)
	adicionar_upgrade_meta(preload("res://resources/progressoes_meta/ganho_experiencia.tres"))
	adicionar_upgrade_meta(preload("res://resources/progressoes_meta/ganho_experiencia.tres"))
	
	
func _on_frasco_experiencia_coletado(number: float) -> void:
	dados_salvos["financas_meta_upgrade"] += number
	
	
func adicionar_upgrade_meta(upgrade: MetaUpgrade) -> void:
	if not dados_salvos["upgrades_meta"].has(upgrade.id):
		dados_salvos["upgrades_meta"][upgrade.id] = {
			"quantidade": 0
		}
		
	dados_salvos["upgrades_meta"][upgrade.id]["quantidade"] += 1
	
	print_debug(dados_salvos)
