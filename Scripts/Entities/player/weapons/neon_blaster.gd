class_name NeonBlasterWeapon
extends Weapon

@export var basic_attack_projectile: PackedScene
@export var special_projectile: PackedScene

func _on_use_basic_attack() -> void:
	var origin_pos: Vector2 = get_parent_entity().position

	ProjectileHandler.spawn_projectile(
		ProjectileContext.new(
			basic_attack_projectile,
			origin_pos,
			Utils.get_direction_to_target(origin_pos, get_global_mouse_position()),
		)
	)

func _on_use_special() -> void:
	var origin_pos: Vector2 = get_parent_entity().position

	ProjectileHandler.spawn_projectile(
		ProjectileContext.new(
			special_projectile,
			origin_pos,
			Utils.get_direction_to_target(origin_pos, get_global_mouse_position()),
		)
	)
