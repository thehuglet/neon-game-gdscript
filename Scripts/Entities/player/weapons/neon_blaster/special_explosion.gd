extends Area2D

@export var _damage: int
# @export var _explosion_particles_0: GPUParticles2D
# @export var _explosion_particles_1: GPUParticles2D
@export var _explosion_hitbox: CollisionShape2D
var _is_discarded: bool = false

# func _ready() -> void:
	# _explosion_particles_0.visible = false
	# _explosion_particles_1.visible = false

func _physics_process(delta: float) -> void:
	if _is_discarded:
		return

	# this only runs once, so _ready() may make more sense,
	# but _ready() would not detect the bodies at all,
	# so we are sticking with a _physics_process() one-shot
	var bodies: Array[Node2D] = get_overlapping_bodies()

	for body in bodies:
		if body is not Entity:
			continue
		
		var entity := body as Entity

		var ctx := HitContext.new(entity)
		ctx.damage_amount = _damage
		SignalBus.entity_hit.emit(ctx)

	# TODO: fix particles not firing at all
	# _explosion_particles_0.visible = true
	# _explosion_particles_1.visible = true

	# _explosion_particles_0.restart()
	# print(_explosion_particles_0.self_modulate)
	# _explosion_particles_1.restart()

	_explosion_hitbox.disabled = true

	var despawn_timer := Timer.new()
	despawn_timer.autostart = true
	despawn_timer.one_shot = true
	despawn_timer.wait_time = 2.0
	despawn_timer.timeout.connect(queue_free)
	add_child(despawn_timer)

	_is_discarded = true
