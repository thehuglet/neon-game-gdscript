class_name IdleFloatMovementStrategy
extends MovementStrategy

@export var _movement_speed: int
@export var _max_target_distance: float
@export var _turn_rate: float

var _origin: Vector2
var _current_position: Vector2
var _relative_target_position: Vector2
@onready var _facing_direction: Vector2 = _get_random_position(_max_target_distance)

const ON_TARGET_DISTANCE_THRESHOLD: float = 1.5
const ON_TARGET_DISTANCE_THRESHOLD_VECTOR := Vector2(ON_TARGET_DISTANCE_THRESHOLD, ON_TARGET_DISTANCE_THRESHOLD)

func set_origin(position: Vector2) -> void:
	_origin = position

func update_current_position(position: Vector2) -> void:
	_current_position = position

func calculate_movement_offset(delta: float) -> Vector2:
	var relative_current_position: Vector2 = _current_position - _origin
	var distance_from_target: Vector2 = _relative_target_position - relative_current_position
	var direction_to_target: Vector2 = Utils.get_direction_to_target(relative_current_position, _relative_target_position)

	# Target position changing
	var reached_target: bool = distance_from_target.abs() < ON_TARGET_DISTANCE_THRESHOLD_VECTOR
	if reached_target:
		_relative_target_position = _get_random_position(_max_target_distance)

	_facing_direction = Utils.interpolate_fixed_step(_facing_direction, direction_to_target, _turn_rate * delta)

	return _facing_direction * _movement_speed * delta

func _get_random_position(max_range: float) -> Vector2:	
	return Vector2(
		randf_range(-max_range, max_range),
		randf_range(-max_range, max_range)
	)
