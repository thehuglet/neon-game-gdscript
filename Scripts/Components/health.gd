class_name Health
extends Node

signal health_changed
signal took_damage
signal died
signal started_recovering(recovery_time: float)
signal finished_recovering

@export var health: int
@export var max_health: int
@export var recovery_time_sec: float:
	get:
		return recovery_time_sec
	set(value):
		recovery_time_sec = value

@export_category('References')
## Enables automatic VFX on the entity sprite on damage & healing.
@export var _neon_sprite: NeonSprite
## Enables automatic _hurtbox disabling during recovery. [br][br]
## This can be skipped if the recovery time on this entity is set to [code]0[/code].
@export var _hurtbox: Hurtbox

var is_dead: bool = false
var is_recovering: bool = false
var _remaining_recovery_time: float = 0.0

func _ready() -> void:
	if _hurtbox != null:
		started_recovering.connect(_hurtbox._on_health_started_recovering)
		finished_recovering.connect(_hurtbox._on_health_finished_recovering)
	if _neon_sprite != null:
		took_damage.connect(_neon_sprite._on_health_took_damage)
		started_recovering.connect(_neon_sprite._on_health_started_recovering)

func _physics_process(delta: float) -> void:
	if !is_recovering:
		return
	
	_remaining_recovery_time -= delta
	
	if _remaining_recovery_time <= 0.0:
		is_recovering = false
		finished_recovering.emit()

func damage(damage_amount: int) -> void:
	if is_recovering || is_dead || damage_amount <= 0:
		return
	
	health = maxi(0, health - damage_amount)
	health_changed.emit()
	took_damage.emit()
	
	var uses_recovery: bool = recovery_time_sec != 0.0
	
	if health == 0:
		is_dead = true
		died.emit()
	elif uses_recovery:
		is_recovering = true
		_remaining_recovery_time = recovery_time_sec
		started_recovering.emit(recovery_time_sec)

func heal(heal_amount: int) -> void:
	health = mini(max_health, heal_amount)
	health_changed.emit()
