class_name PlayerMovementStrategy
extends MovementStrategy

@export var _movement_speed: int
var _facing_direction: Vector2

func set_facing_direction(facing_direction: Vector2) -> void:
	_facing_direction = facing_direction

func calculate_movement_offset(delta: float) -> Vector2:
	return _facing_direction * _movement_speed * delta
