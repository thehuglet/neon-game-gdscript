extends ExplosiveProjectile

func _physics_process(delta: float) -> void:
	rotate(8 * delta)

	# super(delta)
