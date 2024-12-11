extends Node

func get_direction_to_target(origin: Vector2, target: Vector2) -> Vector2:
	return (target - origin).normalized()

func interpolate_fixed_step(current: Vector2, target: Vector2, step_size: float) -> Vector2:
	# if current.length() == 0:
	# 	return target.normalized()
	var angle_diff := target.angle_to(current)
	var clamped_rotation: float = clamp(angle_diff, -step_size, step_size)
	var rotated_vector := current.rotated(-clamped_rotation)
	return rotated_vector.normalized()
