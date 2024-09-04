@tool
class_name NeonSpriteComponent
extends Node2D

# TODO: fix the resources folder structure, especially this components'

# Shader uniforms constants for autocompletion
const U_COLOR := 'color'
const U_ALPHA := 'alpha'
const U_EXPAND_RADIUS := 'expand_radius'
const U_HUE_SHIFT := 'hue_shift'
const U_SATURATION := 'saturation'
const U_BRIGHTNESS := 'brightness'

@export var _base_texture: Texture2D:
	get:
		return _base_texture
	set(value):
		_base_texture = value
		_base_sprite.texture = value

@export var _blurred_texture: Texture2D:
	get:
		return _blurred_texture
	set(value):
		_blurred_texture = value
		_blurred_sprite.texture = value

@export_color_no_alpha var _color: Color:
	get:
		return _color
	set(value):
		_color = value
		set_shader_uniform(U_COLOR, value)	

@export var _damage_flash_curve: Curve
@export var _damage_flash_duration: float
@export var _recovery_flash_curve: Curve

@export_category('References')
@export var _base_sprite: Sprite2D
@export var _blurred_sprite: Sprite2D

var _recovery_flash_duration: float = 0.0

var _remaining_damage_flash_time: float = 0.0
var _remaining_recovery_flash_time: float = 0.0

func _physics_process(delta: float) -> void:
	# TODO: tidy up damage & recovery flashing
	var is_damage_flash_running: bool = _remaining_damage_flash_time > 0.0
	var is_recovery_flash_running: bool = _remaining_recovery_flash_time > 0.0

	if is_damage_flash_running:
		_remaining_damage_flash_time = max(_remaining_damage_flash_time - delta, 0.0)
		
		var curve_time: float = 1.0 - (_remaining_damage_flash_time / _damage_flash_duration)
		
		set_shader_uniform(U_EXPAND_RADIUS, _damage_flash_curve.sample(curve_time))
		set_shader_uniform(U_SATURATION, curve_time)
	if is_recovery_flash_running:
		_remaining_recovery_flash_time = max(_remaining_recovery_flash_time - delta, 0.0)
		
		var curve_time: float = 1.0 - (_remaining_recovery_flash_time / _recovery_flash_duration)
		
		set_shader_uniform(U_ALPHA, _recovery_flash_curve.sample(curve_time))
		#set_shader_uniform(U_HUE_SHIFT, -(1.0 - curve_time) / 10)

func set_shader_uniform(uniform_name: String, value: Variant) -> void:
	if _blurred_sprite != null:
		(_blurred_sprite.material as ShaderMaterial).set_shader_parameter(uniform_name, value)
	if _base_sprite != null && uniform_name == U_ALPHA:
		(_base_sprite.material as ShaderMaterial).set_shader_parameter(uniform_name, value)

func _apply_recovery_flash(duration: float) -> void:
	_remaining_recovery_flash_time = duration

func _apply_damage_flash() -> void:
	_remaining_damage_flash_time = _damage_flash_duration

## HealthComponent (auto-connect)
func _on_health_took_damage() -> void:
	_apply_damage_flash()

## HealthComponent (auto-connect)
func _on_health_started_recovering(recovery_time: float) -> void:
	# This is called after _on_health_took_damage()
	# so we'll simply cancel the damage flash that
	# would normally happen for non-recovery entities
	_remaining_damage_flash_time = 0.0
	_recovery_flash_duration = recovery_time
	_apply_recovery_flash(recovery_time)
	
