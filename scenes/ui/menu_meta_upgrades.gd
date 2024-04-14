extends CanvasLayer
class_name MenuMetaUpgrades

@onready var grid_container: GridContainer = %GridContainer

@export var upgrades: Array[MetaUpgrade] = []

var card_meta_upgrade_cena = preload("res://scenes/ui/meta_upgrade_card.tscn")

func _ready() -> void:
	for upgrade in upgrades:
		var card_meta_upgrade = card_meta_upgrade_cena.instantiate() as MetaUpgradeCard
		
		grid_container.add_child(card_meta_upgrade)
		card_meta_upgrade.set_meta_upgrade_abilidade(upgrade)
		
