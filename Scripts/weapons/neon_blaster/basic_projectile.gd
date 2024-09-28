extends DirectHitProjectile

@export var particle: GPUParticles2D

func _ready() -> void:
	var particle_process_mat := particle.process_material as ParticleProcessMaterial 

	particle_process_mat.angle_min = -rotation_degrees
	particle_process_mat.angle_max = -rotation_degrees
	
	super()

# func _process(delta: float) -> void:
# 	particle.emit_particle(Transform2D(), Vector2.ZERO, Color.RED, Color.WHITE, 0)

# 	super(delta)
