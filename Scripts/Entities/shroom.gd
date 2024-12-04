class_name Shroom
extends Entity

@export var _c_neon_sprite: NeonSprite
var _tmp: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_tmp += 0.5 * delta
	_c_neon_sprite.set_hue_shift(_tmp)
