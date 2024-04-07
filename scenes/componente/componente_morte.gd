extends Node2D
class_name ComponenteMorte

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gpu_particles: GPUParticles2D = $GPUParticles2D
@onready var componente_audio_stream_player_2d_aleatorio: ComponenteAudioStreamPlayer2DAleatorio = $ComponenteAudioStreamPlayer2DAleatorio

@export var sprite: Sprite2D
@export var componente_vida: ComponenteVida


func _ready() -> void:
	gpu_particles.texture = sprite.texture
	
	componente_vida.morreu.connect(on_morreu)
	
	
func on_morreu() -> void:
	if owner == null || not owner is Node2D:
		return
	
	var camada_entidades = get_tree().get_first_node_in_group("camada_entidades")
	
	var posicao = owner.global_position
	
	get_parent().remove_child(self)
	camada_entidades.add_child(self)
	
	global_position = posicao
	animation_player.play("padrao")

	componente_audio_stream_player_2d_aleatorio.play_aleatorio()
