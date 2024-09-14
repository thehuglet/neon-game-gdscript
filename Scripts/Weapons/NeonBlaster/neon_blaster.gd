extends Weapon

@export var bullet: PackedScene

func _on_fired_basic_attack() -> void:
	var ctx := BulletContext.new(bullet, owner_ref.position)
	var direction: Vector2 = (get_global_mouse_position() - owner_ref.position).normalized()
	
	ctx.facing_direction = direction.rotated(randf_range(-0.1, 0.1))
	BulletManager.spawn_bullet(ctx)
