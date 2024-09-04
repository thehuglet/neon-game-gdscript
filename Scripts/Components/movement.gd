class_name MovementComponent
extends Node2D

signal updated(position_offset: Vector2)

@export var movement_speed: int

var can_move: bool = true
var movement_direction: Vector2:
	get:
		return _movement_direction
	set(value):
		_movement_direction = value
	
var _movement_direction: Vector2 = Vector2.ZERO
var _knockback_position_offset: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var movement_offset: Vector2 = Vector2.ZERO

	if can_move:
		movement_offset = _movement_direction * movement_speed * delta

	updated.emit(movement_offset + _knockback_position_offset)
	
	# this gets reset reset because last output from
	# the knockback signal never equals Vector2.ZERO
	# (remove this = last tick of knockback forever)
	_knockback_position_offset = Vector2.ZERO

## auto-connected by sibling KnockbackComponent
func _on_knockback_updated(position_offset: Vector2) -> void:
	_knockback_position_offset = position_offset

## auto-connected by sibling KnockbackComponent
func _on_knockback_started() -> void:
	can_move = false

## auto-connected by sibling KnockbackComponent
func _on_knockback_finished() -> void:
	can_move = true
