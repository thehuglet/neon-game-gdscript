extends Projectile

@export var _explosion: PackedScene
@export var _speed: int = 800
@export var _sprite_flash_frequency: float
@export var _sprite_flash_amplitude: float
@export var _sprite_rotation_speed: int
@export var _projectiles_head: GPUParticles2D
@export var _neon_sprite_lite: NeonSpriteLite

# var _last_sine_wave: float = 0.0
var _tick_burst_ran: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	super()

func _process(delta: float) -> void:
	if _is_discarded:
		return

	position += direction * _speed * delta

	_neon_sprite_lite.rotate(_sprite_rotation_speed * delta)

	var sine_wave: float = (sin(_sprite_flash_frequency * Time.get_ticks_msec() / 1000.0) + 1) / 2
	_neon_sprite_lite.alpha_multiplier = 0.2 + _sprite_flash_amplitude * sine_wave
	_projectiles_head.modulate.a = 0.3 + sine_wave * 0.7

	if sine_wave > 0.95 and not _tick_burst_ran:
		# _tick_burst_projectiles.restart()
		# print('restart')
		_tick_burst_ran = true
	elif sine_wave < 0.05:
		_tick_burst_ran = false
		
	# if sine_wave < _last_sine_wave and _last_sine_wave > 0.5:
	# 	print('peak')
	
	# _last_sine_wave = sine_wave

func _spawn_explosion() -> void:
	var instance: Area2D = _explosion.instantiate()
	
	# without this the explosion spawns at (0, 0)
	instance.position = position

	var root: Node = get_tree().current_scene
	root.add_child(instance)

func _on_body_entered(body: CharacterBody2D) -> void:
	# ensures only one explosion spawns
	if _is_discarded:
		return

	_spawn_explosion.call_deferred()
	
	_neon_sprite_lite.visible = false
	discard()
