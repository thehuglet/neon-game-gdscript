extends CollisionShape2D
class_name HurtboxComponent

@export var health: HealthComponent
@export var knockback: KnockbackComponent

func disable_collision() -> void:
	set_deferred('disabled', true)

func enable_collision() -> void:
	set_deferred('disabled', false)

func _ready() -> void:
	SignalBus.connect('entity_hit', _on_entity_hit)

func _on_entity_hit(ctx: HitContext) -> void:
	if ctx.target != get_parent():
		return
	
	if health != null:
		health.damage(ctx.damage)
	if knockback != null:
		var knockback_direction: Vector2 = (ctx.target.position - ctx.source_position).normalized()
		var knockback_vector: Vector2 = knockback_direction * ctx.knockback_distance
		knockback.apply(ctx.source_position, knockback_vector, ctx.knockback_speed)

## auto-connected by sibling HealthComponent
func _on_health_started_recovering() -> void:
	disable_collision()

## auto-connected by sibling HealthComponent
func _on_health_finished_recovering() -> void:
	enable_collision()
