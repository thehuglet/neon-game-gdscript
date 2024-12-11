class_name PlayerDash
extends Node2D

@export var _dash_distance: int
@export var _dash_speed: int
@export_group('Component References')
@export var _movement: Movement
@export var _hurtbox: Hurtbox
@export var _neon_trail: NeonTrail
@export_group('')

var _hurtbox_reenable_timer: Timer

func _ready() -> void:
	_hurtbox_reenable_timer = Timer.new()
	_hurtbox_reenable_timer.timeout.connect(_on_dash_end)
	_hurtbox_reenable_timer.one_shot = true
	add_child(_hurtbox_reenable_timer)

func start_dash(direction: Vector2) -> void:
	_movement.apply_push_motion(direction * _dash_distance, _dash_speed)
	_hurtbox.disable_collision()
	_hurtbox_reenable_timer.start(_movement.push_motion_duration)
	_neon_trail.enabled = true

func _on_dash_end() -> void:
	_hurtbox.enable_collision()
	_neon_trail.enabled = false
