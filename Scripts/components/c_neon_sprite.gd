@tool
class_name NeonSprite
extends Node2D

@export var _base_texture: Texture2D:
	get:
		return _base_texture
	set(value):
		_base_texture = value
		_base_sprite.texture = value

@export var _glow_texture: Texture2D:
	get:
		return _glow_texture
	set(value):
		_glow_texture = value
		_glow_sprite.texture = value

@export_color_no_alpha var _color: Color:
	get:
		return _color
	set(value):
		_color = value
		_set_shader_uniform(_glow_sprite, 'u_color', value)

@export var _damage_flash_curve: Curve
@export var _damage_flash_duration: float
@export var _recovery_flash_curve: Curve

@export var _base_sprite: Sprite2D
@export var _glow_sprite: Sprite2D

var _recovery_flash_duration: float = 0.0
var _remaining_damage_flash_time: float = 0.0
var _remaining_recovery_flash_time: float = 0.0

func _process(delta: float) -> void:
	var is_damage_flash_running: bool = _remaining_damage_flash_time > 0.0
	var is_recovery_flash_running: bool = _remaining_recovery_flash_time > 0.0

	if is_damage_flash_running:
		_update_damage_flash(delta)
	elif is_recovery_flash_running:
		_update_recovery_flash(delta)

func set_hue_shift(value: float) -> void:
	_set_shader_uniform(_glow_sprite, 'u_hue_shift', value)

func _set_shader_uniform(node: Sprite2D, uniform_name: String, value: Variant) -> void:
	if node != null:
		(node.material as ShaderMaterial).set_shader_parameter(uniform_name, value)

func _update_damage_flash(delta: float) -> void:
	_remaining_damage_flash_time = max(_remaining_damage_flash_time - delta, 0.0)
	var curve_time: float = 1.0 - (_remaining_damage_flash_time / _damage_flash_duration)
	var curve_value: float = _damage_flash_curve.sample(curve_time)

	_set_shader_uniform(_glow_sprite, 'u_expand_radius', curve_value * 1.5)
	_set_shader_uniform(_glow_sprite, 'u_luminance_factor', curve_value)

func _update_recovery_flash(delta: float) -> void:
	_remaining_recovery_flash_time = max(_remaining_recovery_flash_time - delta, 0.0)
	var curve_time: float = 1.0 - (_remaining_recovery_flash_time / _recovery_flash_duration)
	var sampled_value: float = _recovery_flash_curve.sample(curve_time)

	_set_shader_uniform(_glow_sprite, 'u_alpha', sampled_value)
	_set_shader_uniform(_base_sprite, 'u_alpha', sampled_value)
	#set_shader_uniform(U_HUE_SHIFT, -(1.0 - curve_time) / 10)
	#set_shader_uniform(U_SATURATION, clamp(curve_time, 0.5, 1.0))

func _apply_damage_flash() -> void:
	_remaining_damage_flash_time = _damage_flash_duration

func _apply_recovery_flash(duration: float) -> void:
	_remaining_recovery_flash_time = duration
	_recovery_flash_duration = duration

## Health (auto-connect)
func _on_health_took_damage() -> void:
	_apply_damage_flash()

## Health (auto-connect)
func _on_health_started_recovering(recovery_time: float) -> void:
	# This cancels the '_on_health_took_damage()' signal
	# damage flash, which always triggers before this
	_remaining_damage_flash_time = 0.0
	_apply_recovery_flash(recovery_time)
