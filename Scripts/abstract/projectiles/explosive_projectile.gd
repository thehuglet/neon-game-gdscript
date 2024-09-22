## Extending methods listed below requires a [code]super()[/code] call:[br]
## [br]
## [code]_ready()[/code][br]
## [code]_on_body_entered()[/code][br]

class_name ExplosiveProjectile
extends Projectile

## Has to inherit [Explosion]
@export var explosion: PackedScene

func _ready() -> void:
	body_entered.connect(_on_body_entered)

	super()

func spawn_explosion() -> void:
	var instance: Explosion = explosion.instantiate()
	instance.damage = damage
	instance.position = position

	var root: Node = get_tree().current_scene
	root.add_child(instance)

func _on_body_entered(body: CharacterBody2D) -> void:
	spawn_explosion.call_deferred()
	queue_free()
