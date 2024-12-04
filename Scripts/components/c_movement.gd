class_name Movement
extends Node

## Signal [code]updated(position_offset: Vector2)[/code] returns a position offset.
## Connect it to the entity script and [b]ADD it to the entity position[/b] for forward movement.[br]
## Usage:
## [codeblock]
## func _on_movement_updated(position_offset):
##     self.position += position_offset
## [/codeblock][br]
## [code]set_direction()[/code] controls the movement direction.

signal updated(position_offset: Vector2)
signal push_motion_started
signal push_motion_ended

@export var _movement_speed: int
@export var _is_knockback_immune: bool = false

var is_knockback_immune: bool:
	get: return _is_knockback_immune
var movement_speed: int:
	get: return _movement_speed
var push_motion_duration: float:
	get: return _push_motion_duration
var _is_immobilized: bool = false
var _movement_direction := Vector2.ZERO
var _push_motion_end_pos: Vector2
var _push_motion_duration: float
var _push_motion_elapsed_time: float
var _push_motion_is_ongoing: bool = false
var _push_motion_last_offset: Vector2

func _process(delta: float) -> void:
	var movement_offset: Vector2 = _update_push_motion(delta)

	if _movement_direction == Vector2.ZERO && movement_offset == Vector2.ZERO:
		return

	if !_is_immobilized:
		movement_offset += _movement_direction * _movement_speed * delta

	updated.emit(movement_offset)

func set_direction(normalized_direction: Vector2) -> void:
	_movement_direction = normalized_direction

func apply_push_motion(motion: Vector2, speed: float) -> void:
	const BASE_MOTION_MULTIPLIER = 1.5
	const BASE_SPEED_MULTIPLIER = 30

	motion *= BASE_MOTION_MULTIPLIER
	_push_motion_end_pos = motion
	_push_motion_duration = motion.length() / (speed * BASE_SPEED_MULTIPLIER)
	_push_motion_elapsed_time = 0
	_push_motion_is_ongoing = true
	push_motion_started.emit()
	_push_motion_last_offset = Vector2.ZERO

func _update_push_motion(delta: float) -> Vector2:
	if !_push_motion_is_ongoing:
		return Vector2.ZERO

	_push_motion_elapsed_time += delta
	var t: float = _push_motion_elapsed_time / _push_motion_duration
	var is_finished: bool = t >= 1.0

	if is_finished:
		_push_motion_is_ongoing = false
		var final_offset: Vector2 = _push_motion_end_pos - _push_motion_last_offset
		return final_offset

	t = _ease_out_quad(t)
	var current_offset := Vector2.ZERO.lerp(_push_motion_end_pos, t)
	var offset: Vector2 = current_offset - _push_motion_last_offset
	_push_motion_last_offset = current_offset
	return offset

func _ease_out_quad(t: float) -> float:
	return t * (2 - t)
