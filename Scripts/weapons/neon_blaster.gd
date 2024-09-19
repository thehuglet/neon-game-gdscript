extends Weapon

@export var projectile: PackedScene

func _on_fired_basic_attack() -> void:
	var facing_direction: Vector2 = (get_global_mouse_position() - owner_ref.position).normalized()
	
	# facing_direction = facing_direction.rotated(randf_range(-0.1, 0.1))

	var ctx := ProjectileContext.new(
		projectile,
		owner_ref.position,
		facing_direction
	)

	ProjectileManager.spawn_projectile(ctx)
