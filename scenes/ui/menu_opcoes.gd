extends CanvasLayer
class_name MenuOpcoes

## volta para a cena anterior
signal voltar_pressionado

@onready var slider_sfx: HSlider = %SliderSFX
@onready var slider_musica: HSlider = %SliderMusica
@onready var check_box_tela_cheia: CheckBox = %CheckBoxTelaCheia
@onready var botao_voltar: Button = %BotaoVoltar
@onready var label_tela_cheia: Label = %LabelTelaCheia


func _ready() -> void:
	slider_sfx.value = get_volume_bus_porcentagem("sfx")
	slider_musica.value = get_volume_bus_porcentagem("musica")
	
	# para reutilizar os métodos, cria-se uma função que altera qualquer slider, passando o nome
	slider_sfx.value_changed.connect(_on_slider_audio_changed.bind("sfx"))
	slider_musica.value_changed.connect(_on_slider_audio_changed.bind("musica"))
	
	
	if DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN:
		check_box_tela_cheia.toggle_mode = false
	else:
		check_box_tela_cheia.toggle_mode = true


func get_volume_bus_porcentagem(bus_name: String) -> float:
	# obtem o indice do bus para se alterar
	var bus_index: int = AudioServer.get_bus_index(bus_name)

	# obtem o volume em decibeis do bus	
	var volume_decibel: float = AudioServer.get_bus_volume_db(bus_index)
	
	# converte e retorna os decibeis para uso em porcentagem do slider
	return db_to_linear(volume_decibel)


func set_volume_bus_porcentagem(bus_name: String, porcentagem: float) -> void:
	# obtem o indice do bus para se alterar
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	
	# converte porcentagem em decibeis
	var volume_decibel: float = linear_to_db(porcentagem)
	
	# altera o valor no audio
	AudioServer.set_bus_volume_db(bus_index, volume_decibel)


func _on_slider_audio_changed(value: float, bus_name: String):
	set_volume_bus_porcentagem(bus_name, value)


func _on_check_box_tela_cheia_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
		label_tela_cheia.text = "Modo Janela"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		label_tela_cheia.text = "Modo Tela Cheia"


func _on_botao_voltar_pressed() -> void:
	TransicaoTela.transicao()
	await TransicaoTela.metade_transicao_alcancada
	
	voltar_pressionado.emit()
