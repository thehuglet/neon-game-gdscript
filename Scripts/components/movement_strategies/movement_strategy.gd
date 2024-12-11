class_name MovementStrategy
extends Node

func calculate_movement_offset(delta: float) -> Vector2:
	push_error('Movement strategy "', name, '" should implement the "calculate_movement_offset() method"')
	return Vector2.ZERO
