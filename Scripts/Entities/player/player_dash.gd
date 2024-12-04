class_name PlayerDash
extends Node2D

@export var _dash_distance: int
@export var _dash_speed: int
@export var _c_movement: Movement
@export var _c_hurtbox: Hurtbox

var _hurtbox_reenable_timer: Timer

func _ready() -> void:
	_hurtbox_reenable_timer = Timer.new()
	_hurtbox_reenable_timer.timeout.connect(func() -> void: _c_hurtbox.enable_collision())
	_hurtbox_reenable_timer.one_shot = true
	add_child(_hurtbox_reenable_timer)

func start_dash(direction: Vector2) -> void:
	_c_movement.apply_push_motion(direction * _dash_distance, _dash_speed)
	_c_hurtbox.disable_collision()
	_hurtbox_reenable_timer.start(_c_movement.push_motion_duration)
