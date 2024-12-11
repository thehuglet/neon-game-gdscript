class_name CollisionAttack
extends Area2D

@export var _damage_amount: int
@export var _knockback_distance: int = 150
@export var _knockback_speed: float = 25

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: CharacterBody2D) -> void:
	var ctx := HitContext.new(body)

	ctx.source_position = (get_parent() as CharacterBody2D).position + self.position
	ctx.damage_amount = _damage_amount
	ctx.knockback_distance = _knockback_distance
	ctx.knockback_speed = _knockback_speed

	SignalBus.entity_hit.emit(ctx)
