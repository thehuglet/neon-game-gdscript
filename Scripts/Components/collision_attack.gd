class_name CollisionAttack
extends Area2D

@export var damage: int
@export var knockback_distance: int
@export var knockback_speed: float

func _ready() -> void:
	connect('body_entered', _on_body_entered)

func _on_body_entered(body: CharacterBody2D) -> void:
	var ctx: HitContext = HitContext.new(body)

	ctx.source_position = (get_parent() as CharacterBody2D).position + self.position
	ctx.damage = damage
	ctx.knockback_distance = knockback_distance
	ctx.knockback_speed = knockback_speed
	
	SignalBus.entity_hit.emit(ctx)
