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
var _movement_direction: Vector2 = Vector2.ZERO
var _motion_position_offset: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var movement_offset: Vector2 = Vector2.ZERO

	if _movement_direction == Vector2.ZERO && _motion_position_offset == Vector2.ZERO:
		return
	
	if can_move:
		movement_offset = _movement_direction * movement_speed * delta

	updated.emit(movement_offset + _motion_position_offset)

func set_direction(normalized_direction: Vector2) -> void:
	_movement_direction = normalized_direction

## Motion (auto-connect)
func _on_motion_updated(position_offset: Vector2) -> void:
	_motion_position_offset = position_offset

## Motion (auto-connect)
func _on_motion_started() -> void:
	can_move = false

## Motion (auto-connect)
func _on_motion_finished() -> void:
	can_move = true
