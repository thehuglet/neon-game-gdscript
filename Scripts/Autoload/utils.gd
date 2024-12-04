extends Node

func get_direction_to_target(origin: Vector2, target: Vector2) -> Vector2:
	return (target - origin).normalized()
