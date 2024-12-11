class_name RotoGlow
extends Entity

@export var _turn_speed: float
@export var _turn_speed_variation: float = 0.2
@export var _base_sprite_rotation_speed: float
@export var _base_trail_spawn_interval_sec: float = 0.3
@export var _movement_strategy: HomingMovementStrategy
@export var _neon_sprite: NeonSprite
@export var _neon_trail: NeonTrail
@export var _movement: Movement

func _ready() -> void:
	_movement.updated.connect(_on_movement_updated)
	_movement.set_movement_strategy(_movement_strategy)
	randomize()
	_turn_speed *= 1.0 + randf_range(_turn_speed_variation, -_turn_speed_variation)

func _process(delta: float) -> void:
	var target: Player = get_tree().get_first_node_in_group('player')
	var direction_to_target: Vector2 = Utils.get_direction_to_target(position, target.position)
	_movement_strategy.set_target_direction(direction_to_target)
	
	var speed_multiplier: float = _movement_strategy.get_speed_multiplier()

	_neon_sprite.rotation += _base_sprite_rotation_speed * speed_multiplier * 0.33 * delta
	_neon_trail.update_rotation(_neon_sprite.rotation)
	_neon_trail.spawn_interval_sec = _base_trail_spawn_interval_sec / speed_multiplier * 7.0

func _on_movement_updated(position_offset: Vector2) -> void:
	position += position_offset
