class_name Projectile
extends Area2D

var direction: Vector2 = Vector2.ZERO
var _is_discarded: bool = false

func _ready() -> void:
	monitorable = false

func discard() -> void:
	if _is_discarded:
		return

	_is_discarded = true
	# visible = false
	set_deferred('monitoring', false)

	var despawn_timer := Timer.new()
	despawn_timer.autostart = true
	despawn_timer.one_shot = true
	despawn_timer.wait_time = 2.0
	despawn_timer.timeout.connect(queue_free)
	add_child(despawn_timer)
