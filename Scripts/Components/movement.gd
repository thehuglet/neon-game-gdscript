## Signal [code]updated(position_offset: Vector2)[/code] returns a position offset.
## Connect it to the entity script and [b]ADD it to the entity position[/b] for forward movement.[br]
## Usage:
## [codeblock]
## func _on_movement_updated(position_offset):
##     self.position += position_offset
## [/codeblock][br]
## Modify [code]movement_direction[/code] to set a movement direction.

class_name Movement
extends Node

signal updated(position_offset: Vector2)

@export var movement_speed: int

var can_move: bool = true

## Determines the direction the entity will be moving. Has to be a normalized vector.
var movement_direction: Vector2:
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
	# the knockback signal never sends out Vector2.ZERO
	# (remove this = last tick of knockback lasts forever)
	_knockback_position_offset = Vector2.ZERO

## Knockback (auto-connect)
func _on_knockback_updated(position_offset: Vector2) -> void:
	_knockback_position_offset = position_offset

## Knockback (auto-connect)
func _on_knockback_started() -> void:
	# can_move = false
	pass

## Knockback (auto-connect)
func _on_knockback_finished() -> void:
	# can_move = true
	pass
