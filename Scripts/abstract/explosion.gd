class_name Explosion
extends Area2D

signal on_exploded
signal on_target_hit

@export var damage: int

@export_category('References')
@export var _hitbox: CollisionShape2D

func _physics_process(delta: float) -> void:
	var bodies: Array[Node2D] = get_overlapping_bodies()

	if len(bodies) > 0:
		explode(bodies)
		queue_free()

func explode(bodies: Array[Node2D]) -> void:
	on_exploded.emit()

	for body in bodies:
		var ctx := HitContext.new(body as CharacterBody2D)
		ctx.damage = damage
		SignalBus.entity_hit.emit(ctx)

		on_target_hit.emit()

	_hitbox.set_disabled(true)
