class_name Knockback
extends Node

signal updated(position_offset: Vector2)
signal started
signal finished

@export_category('References')
## Required for knockback to work, as the module automatically
## passes knockback related calculations to the [MovementComponent].
@export var _movement: Movement

var is_active: bool
var _start_pos: Vector2
var _end_pos: Vector2
var _last_offset: Vector2
var _duration: float
var _elapsed_time: float

const _BASE_MOTION_MULTIPLIER = 1.5
const _BASE_SPEED_MULTIPLIER = 30

func apply(current_pos: Vector2, motion: Vector2, speed: float) -> void:
	motion *= _BASE_MOTION_MULTIPLIER
	
	_start_pos = current_pos
	_end_pos = current_pos + motion
	_duration = motion.length() / (speed * _BASE_SPEED_MULTIPLIER);
	_elapsed_time = 0
	is_active = true
	started.emit()
	_last_offset = Vector2.ZERO

func _ease_out_quad(t: float) -> float:
	return t * (2 - t)

func _ready() -> void:
	if _movement != null:
		updated.connect(_movement._on_knockback_updated)
		started.connect(_movement._on_knockback_started)
		finished.connect(_movement._on_knockback_finished)

func _process(delta: float) -> void:
	if (!is_active):
		return
	
	_elapsed_time += delta
	var t: float = _elapsed_time / _duration
	var is_finished: bool = t >= 1.0
	
	if is_finished:
		is_active = false
		finished.emit()
		var final_offset: Vector2 = _end_pos - _start_pos - _last_offset
		_last_offset = _end_pos - _start_pos
		updated.emit(final_offset)
	
	t = _ease_out_quad(t)
	var current_offset: Vector2 = _start_pos.lerp(_end_pos, t) - _start_pos
	var offset: Vector2 = current_offset - _last_offset
	_last_offset = current_offset
	updated.emit(offset)
