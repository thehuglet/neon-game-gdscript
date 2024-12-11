class_name HomingMovementStrategy
extends MovementStrategy


@export_group('Forward Movement')
@export var _base_movement_speed: int
@export var _acceleration_rate: float
@export var _deceleration_rate: float
@export_range(1.0, 25.0, 0.1) var _max_speed_multiplier: float
@export var _speed_variation: float

@export_group('Steering')
@export var _base_turn_rate: float
@export var _turn_speed_variation: float
@export var _acceleration_cone_angle_deg: float

var _speed_multiplier: float = 1.0
var _facing_direction := Vector2.UP
var _target_direction: Vector2
@onready var _current_turn_speed_variation: float = 1.0 + randf_range(_turn_speed_variation, -_turn_speed_variation)
@onready var _current_speed_variation: float = 1.0 + randf_range(_speed_variation, -_speed_variation)

func set_target_direction(direction: Vector2) -> void:
	_target_direction = direction

	if _facing_direction == null:
		_facing_direction = _target_direction

func get_speed_multiplier() -> float:
	return _speed_multiplier

func calculate_movement_offset(delta: float) -> Vector2:
	var angle_diff_deg: float = absf(rad_to_deg(angle_difference(_facing_direction.angle(), _target_direction.angle())))

	# speed multiplier logic
	if angle_diff_deg < _acceleration_cone_angle_deg:
		_speed_multiplier += _acceleration_rate * delta
	else:
		_speed_multiplier -= _deceleration_rate * delta
	_speed_multiplier = clamp(_speed_multiplier, 1.0, _max_speed_multiplier)

	# turning logic
	var turn_rate: float = _base_turn_rate * _current_turn_speed_variation / _speed_multiplier * 3.0 * delta
	_facing_direction = Utils.interpolate_fixed_step(_facing_direction, _target_direction, turn_rate)

	return _facing_direction * _current_speed_variation * _base_movement_speed * _speed_multiplier * 0.2 * delta
