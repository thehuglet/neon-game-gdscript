class_name GPUParticles2DExtras
extends GPUParticles2D

@export var _one_shot_init_fix: bool = false
@export_range(0.0, 10.0, 0.1) var _rgb_overdrive_factor: float = 0.0

var _one_shot_fired: bool = false

func _ready() -> void:
	self_modulate.r *= _rgb_overdrive_factor + 1
	self_modulate.g *= _rgb_overdrive_factor + 1
	self_modulate.b *= _rgb_overdrive_factor + 1

func _process(delta: float) -> void:
	if _one_shot_init_fix and not _one_shot_fired:
		_one_shot_fired = true
		restart()
