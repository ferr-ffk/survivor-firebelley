extends Node

signal frasco_experiencia_coletado(n: float)
signal abilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeAbilidade)
signal jogador_atingido


func emitir_frasco_experiencia_coletado(n: float) -> void:
	frasco_experiencia_coletado.emit(n)
	

func emitir_abilidade_adicionada(upgrades_atuais: Dictionary, upgrade: UpgradeAbilidade) -> void:
	abilidade_adicionada.emit(upgrades_atuais, upgrade)


func emitir_jogador_atingido() -> void:
	jogador_atingido.emit()
