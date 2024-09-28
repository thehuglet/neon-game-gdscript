class_name Motion
extends Node

signal updated(position_offset: Vector2)
signal started
signal finished

@export var is_knockback_immune: bool = false

@export_category('References')
## Required for motion to work, as the module automatically
## passes motion related calculations to the [Movement] component.
@export var _movement: Movement

var is_active: bool
var _end_pos: Vector2
var _last_offset: Vector2
var _duration: float
var _elapsed_time: float
var _emit_last_empty_offset: bool

const _BASE_MOTION_MULTIPLIER = 1.5
const _BASE_SPEED_MULTIPLIER = 30

func _ready() -> void:
	if _movement != null:
		updated.connect(_movement._on_motion_updated)
		started.connect(_movement._on_motion_started)
		finished.connect(_movement._on_motion_finished)

func _process(delta: float) -> void:
	if !is_active && !_emit_last_empty_offset:
		return
	
	_elapsed_time += delta
	var t: float = _elapsed_time / _duration
	var is_finished: bool = t >= 1.0
	
	# This ensures the last offset the signal emits is a Vector2.ZERO
	if _emit_last_empty_offset:
		_emit_last_empty_offset = false
		updated.emit(Vector2.ZERO)
		finished.emit()
		return

	if is_finished:
		is_active = false
		_emit_last_empty_offset = true
		var final_offset: Vector2 = _end_pos - _last_offset
		_last_offset = _end_pos
		updated.emit(final_offset)
	
	t = _ease_out_quad(t)
	var current_offset: Vector2 = Vector2.ZERO.lerp(_end_pos, t)
	var offset: Vector2 = current_offset - _last_offset
	_last_offset = current_offset
	updated.emit(offset)

func apply(motion: Vector2, speed: float) -> void:
	motion *= _BASE_MOTION_MULTIPLIER

	_end_pos = motion
	_duration = motion.length() / (speed * _BASE_SPEED_MULTIPLIER)
	_elapsed_time = 0
	is_active = true
	started.emit()
	_last_offset = Vector2.ZERO

func calculate_motion_duration(motion: Vector2, speed: float) -> float:
	return motion.length() / (speed * _BASE_SPEED_MULTIPLIER)

func _ease_out_quad(t: float) -> float:
	return t * (2 - t)
