class_name Shroom
extends Entity

@export var _neon_sprite: NeonSprite
@export var _movement: Movement
@export var _movement_strategy: IdleFloatMovementStrategy

var _tmp: float = 0.0

func _ready() -> void:
	_tmp = randf_range(0.0, 10.0)
	_movement_strategy.set_origin(position)
	_movement.set_movement_strategy(_movement_strategy)
	_movement.updated.connect(
		func(position_offset: Vector2) -> void:
			position += position_offset
	)

func _process(delta: float) -> void:
	_tmp += 0.5 * delta
	_neon_sprite.set_hue_shift(_tmp)
	_movement_strategy.update_current_position(position)
