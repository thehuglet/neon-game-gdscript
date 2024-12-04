class_name ProjectileOld
extends Area2D

@export var damage: int = 1
@export var speed: int = 800
var direction: Vector2 = Vector2.ZERO

var _is_despawning: bool = false

func _ready() -> void:
	monitorable = false

func _process(delta: float) -> void:
	position += direction * speed * delta

func despawn() -> void:
	if _is_despawning:
		return

	_is_despawning = true
	speed = 0
	set_deferred('monitoring', false)

	var despawn_timer := Timer.new()
	despawn_timer.autostart = true
	despawn_timer.one_shot = true
	despawn_timer.wait_time = 2.0
	despawn_timer.timeout.connect(_despawn)
	add_child(despawn_timer)

func _despawn() -> void:
	queue_free()
