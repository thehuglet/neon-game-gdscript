@tool
class_name NeonSpriteComponent
extends Node2D

var U_COLOR := 'color'
var U_ALPHA := 'alpha'
var U_EXPAND_RADIUS := 'expand_radius'
var U_HUE_SHIFT := 'hue_shift'
var U_SATURATION := 'saturation'
var U_BRIGHTNESS := 'brightness'

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

@export_category('References')
@export var _base_sprite: Sprite2D
@export var _blurred_sprite: Sprite2D

var _remaining_damage_flash_time: float = 0.0

func _physics_process(delta: float) -> void:
	if _remaining_damage_flash_time > 0.0:
		_remaining_damage_flash_time = max(_remaining_damage_flash_time - delta, 0.0)

		var curve_time: float = 1.0 - (_remaining_damage_flash_time / _damage_flash_duration)

		set_shader_uniform(U_EXPAND_RADIUS, _damage_flash_curve.sample(curve_time))
		set_shader_uniform(U_SATURATION, curve_time)

func set_shader_uniform(uniform_name: String, value: Variant) -> void:
	if _blurred_sprite != null:
		(_blurred_sprite.material as ShaderMaterial).set_shader_parameter(uniform_name, value)

func _apply_damage_flash() -> void:
	_remaining_damage_flash_time = _damage_flash_duration
	
## HealthComponent (auto-connect)
func _on_health_took_damage() -> void:
	_apply_damage_flash()
