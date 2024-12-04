extends Projectile

@export var _speed: int = 800
@export var _damage: int = 1
@export var _trail: Line2D
@export var _max_trail_length: int
@export var _particles_head: GPUParticles2D
@export var _particles_tail: GPUParticles2D
@export var _c_neon_sprite_lite: NeonSpriteLite

func _ready() -> void:
	super()
	body_entered.connect(_on_body_entered)
	_trail.top_level = true

func _process(delta: float) -> void:
	if _is_discarded:
		return

	position += direction * _speed * delta

func _physics_process(delta: float) -> void:
	if _is_discarded:
		# without this the trail doesn't smoothly clean itself up
		if _trail.get_point_count() > 0:
			_trail.remove_point(0)
		return

	_trail.add_point(position)
	
	if _trail.get_point_count() > _max_trail_length:
		_trail.remove_point(0)

func _on_body_entered(body: CharacterBody2D) -> void:
	# ensures only one entity can be hit
	if _is_discarded:
		return

	var ctx := HitContext.new(body)
	ctx.damage_amount = _damage
	SignalBus.entity_hit.emit(ctx)

	_particles_head.emitting = false
	_particles_tail.emitting = false
	_c_neon_sprite_lite.visible = false
	discard()
	
