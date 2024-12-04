extends Node2D

@export var _particles: Array[GPUParticles2D]
@export var _glow_amount: float = 0.0

func _ready() -> void:
	for particle in _particles:
		particle.self_modulate.r *= _glow_amount + 1.0
		particle.self_modulate.g *= _glow_amount + 1.0
		particle.self_modulate.b *= _glow_amount + 1.0
