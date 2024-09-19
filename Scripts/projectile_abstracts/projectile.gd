class_name Projectile
extends Area2D

@export var damage: int

var direction: Vector2

func _ready() -> void:
	monitorable = false
	collision_layer = 0
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: CharacterBody2D) -> void:
	var ctx: HitContext = HitContext.new(body)
	ctx.damage = damage
	SignalBus.entity_hit.emit(ctx)
	queue_free()
