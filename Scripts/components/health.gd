extends Node
class_name Health

signal health_changed
signal took_damage
signal died
signal started_recovering(recovery_time: float)
signal finished_recovering

@export var _recovery_time_sec: float
@export var _health: int
@export var _max_health: int

@export_group('Component References')
@export var _neon_sprite: NeonSprite		## Enables automatic VFX on the entity sprite on damage (optional)
@export var _hurtbox: Hurtbox				## Enables automatic hurtbox disabling during recovery (optional)
@export_group('')

var health: int:
	get: return _health
var max_health: int:
	get: return _max_health
var is_recovering: bool:
	get: return _is_recovering
var is_dead: bool:
	get: return _is_dead
var _is_recovering: bool = false
var _remaining_recovery_time: float = 0.0
var _is_dead: bool = false

func _ready() -> void:
	if _hurtbox != null:
		started_recovering.connect(_hurtbox._on_health_started_recovering)
		finished_recovering.connect(_hurtbox._on_health_finished_recovering)
	if _neon_sprite != null:
		took_damage.connect(_neon_sprite._on_health_took_damage)
		started_recovering.connect(_neon_sprite._on_health_started_recovering)

func _physics_process(delta: float) -> void:
	if !_is_recovering:
		return
	
	_remaining_recovery_time -= delta
	
	if _remaining_recovery_time <= 0.0:
		_is_recovering = false
		finished_recovering.emit()

func damage(damage_amount: int) -> void:
	if _is_recovering || _is_dead || damage_amount <= 0:
		return
	
	_health = maxi(0, _health - damage_amount)
	health_changed.emit()
	took_damage.emit()
	
	var uses_recovery: bool = _recovery_time_sec != 0.0
	
	if _health == 0:
		_is_dead = true
		died.emit()
	elif uses_recovery:
		_is_recovering = true
		_remaining_recovery_time = _recovery_time_sec
		started_recovering.emit(_recovery_time_sec)

func heal(heal_amount: int) -> void:
	_health = mini(_max_health, heal_amount)
	health_changed.emit()
