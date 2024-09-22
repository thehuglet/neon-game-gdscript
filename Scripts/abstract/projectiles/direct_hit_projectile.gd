## Extending methods listed below requires a [code]super()[/code] call:[br]
## [br]
## [code]_ready()[/code][br]
## [code]_on_body_entered()[/code][br]

class_name DirectHitProjectile
extends Projectile

@export var punch_through: int = 0

var _targets_hit: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

	super()

func _on_body_entered(body: CharacterBody2D) -> void:
	if _targets_hit > punch_through:
		return

	var ctx: HitContext = HitContext.new(body)
	ctx.damage = damage
	SignalBus.entity_hit.emit(ctx)
	
	_targets_hit += 1

	if _targets_hit > punch_through:
		queue_free()
	
