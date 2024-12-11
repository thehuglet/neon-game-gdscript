class_name Hurtbox
extends CollisionShape2D

@export_group('Component References')
@export var _health: Health			## Allows the entity to be damaged on collision	(optional)
@export var _movement: Movement 	## Allows the entity to be affected by knockback on collision (optional)
@export_group('')

func _ready() -> void:
	SignalBus.entity_hit.connect(_on_entity_hit)

func disable_collision() -> void:
	set_deferred('disabled', true)

func enable_collision() -> void:
	set_deferred('disabled', false)

func _on_entity_hit(ctx: HitContext) -> void:
	if ctx.target != get_parent():
		return
	
	if _health != null:
		_health.damage(ctx.damage_amount)
	if _movement != null && !_movement.is_knockback_immune:
		if ctx.knockback_distance != 0.0 and ctx.knockback_distance != 0.0:
			var knockback_direction: Vector2 = (ctx.target.position - ctx.source_position).normalized()
			var knockback_vector: Vector2 = knockback_direction * ctx.knockback_distance
			_movement.apply_push_motion(knockback_vector, ctx.knockback_speed)

## Health (auto-connect)
func _on_health_started_recovering(recovery_time: float) -> void:
	disable_collision()

## Health (auto-connect)
func _on_health_finished_recovering() -> void:
	enable_collision()
