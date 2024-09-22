extends Weapon

@export var basic_attack_projectile: PackedScene
@export var special_projectile: PackedScene

# TODO: make an util for facing direction

func _on_fired_basic_attack() -> void:
	var facing_direction: Vector2 = (get_global_mouse_position() - owner_ref.position).normalized()
	
	# facing_direction = facing_direction.rotated(randf_range(-0.1, 0.1))

	ProjectileManager.spawn_projectile(
		ProjectileContext.new(
			basic_attack_projectile,
			owner_ref.position,
			facing_direction,
	)
)

func _on_used_special() -> void:
	var facing_direction: Vector2 = (get_global_mouse_position() - owner_ref.position).normalized()

	ProjectileManager.spawn_projectile(
		ProjectileContext.new(
			special_projectile,
			owner_ref.position,
			facing_direction,
		)
	)
	
