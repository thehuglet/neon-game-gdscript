class_name LinearProjectile
extends Projectile

@export var speed: float

func _process(delta: float) -> void:
	position += direction * speed * delta
