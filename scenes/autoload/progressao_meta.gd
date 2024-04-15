extends Node

const CAMINHO_ARQUIVO_SAVE = "user://data.save"

var dados_salvos: Dictionary = {
	"financas_meta_upgrade": 0,
	"upgrades_meta": {},
}

func _ready() -> void:
	EventosJogo.frasco_experiencia_coletado.connect(_on_frasco_experiencia_coletado)
	
	carregar_save()
	
	
func salvar() -> void:
	var file = FileAccess.open(CAMINHO_ARQUIVO_SAVE, FileAccess.WRITE)
	
	file.store_var(dados_salvos)
	

func carregar_save() -> void:
	if !FileAccess.file_exists(CAMINHO_ARQUIVO_SAVE):
		return
	
	var arquivo = FileAccess.open(CAMINHO_ARQUIVO_SAVE, FileAccess.READ)
	
	dados_salvos = arquivo.get_var()
	

func get_contagem_upgrade(upgrade_id: String) -> int:
	if dados_salvos["upgrade_meta"].has(upgrade_id):
		return dados_salvos["upgrade_meta"][upgrade_id]["quantidade"]
		
	return 0
	
	
func adicionar_upgrade_meta(upgrade: MetaUpgrade) -> void:
	if not dados_salvos["upgrades_meta"].has(upgrade.id):
		dados_salvos["upgrades_meta"][upgrade.id] = {
			"quantidade": 0
		}
		
	dados_salvos["upgrades_meta"][upgrade.id]["quantidade"] += 1
	
	salvar()
	

func _on_frasco_experiencia_coletado(number: float) -> void:
	dados_salvos["financas_meta_upgrade"] += number
	
