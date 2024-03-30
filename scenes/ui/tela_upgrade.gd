extends CanvasLayer
class_name TelaUpgrade

signal upgrade_selecionado(upgrade: UpgradeAbilidade)

@export var upgrade_abilidade_card: PackedScene

@onready var container_card: HBoxContainer = %ContainerCard

func _ready() -> void:
	# pausa o jogo quando instanciado
	# **é necessário mudar o process_mode para always
	get_tree().paused = true


func set_upgrade_abilidade(upgrades: Array[UpgradeAbilidade]) -> void:
	var delay: float = 0.0
	
	for upgrade in upgrades:
		var instancia_card: UpgradeAbilidadeCard = upgrade_abilidade_card.instantiate() as UpgradeAbilidadeCard
		
		container_card.add_child(instancia_card)
		instancia_card.set_upgrade_abilidade(upgrade)
		instancia_card.play_animacao_aparecer(delay)
		instancia_card.abilidade_selecionada.connect(on_abilidade_selecionada.bind(upgrade))
		delay += 0.3
		
		
func on_abilidade_selecionada(upgrade: UpgradeAbilidade) -> void:
	get_tree().paused = false
	upgrade_selecionado.emit(upgrade)
	queue_free()
