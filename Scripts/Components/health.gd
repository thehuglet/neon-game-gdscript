extends Node2D
class_name HealthComponent

signal health_changed
signal took_damage
signal died
signal started_recovering
signal finished_recovering

# TODO: add health debug and other debug options for components (togglable in inspector)

@export var health: int
@export var max_health: int
@export var recovery_time_sec: float:
	get:
		return recovery_time_sec
	set(value):
		recovery_time_sec = value
		_uses_recovery = recovery_time_sec != 0.0

@export var hurtbox: HurtboxComponent
@export var neon_sprite: NeonSpriteComponent

var is_dead: bool = false
var is_recovering: bool = false
var _uses_recovery: bool
var _remaining_recovery_time: float = 0.0

func damage(damage_amount: int) -> void:
	if is_recovering || is_dead || damage_amount <= 0:
		return
	
	health = maxi(0, health - damage_amount)
	health_changed.emit()
	took_damage.emit()
	
	if health == 0:
		is_dead = true
		died.emit()
	elif _uses_recovery:
		is_recovering = true
		_remaining_recovery_time = recovery_time_sec
		started_recovering.emit()

func heal(heal_amount: int) -> void:
	health = mini(max_health, heal_amount)
	health_changed.emit()

func _ready() -> void:
	if hurtbox != null:
		started_recovering.connect(hurtbox._on_health_started_recovering)
		finished_recovering.connect(hurtbox._on_health_finished_recovering)
	
	if neon_sprite != null:
		took_damage.connect(neon_sprite._on_health_took_damage)

func _physics_process(delta: float) -> void:
	if !is_recovering:
		return
	
	_remaining_recovery_time -= delta
	
	if _remaining_recovery_time <= 0.0:
		is_recovering = false
		finished_recovering.emit()
