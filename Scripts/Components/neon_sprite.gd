@tool
extends Node2D
class_name NeonSpriteComponent

# TODO(Shaders): Fix shader code, fix material name 

@export var base_texture: Texture2D:
	get:
		return base_texture
	set(value):
		base_texture = value
		_base_sprite.texture = value

@export var glow_texture: Texture2D:
	get:
		return glow_texture
	set(value):
		glow_texture = value
		_glow_sprite.texture = value

@export_color_no_alpha var glow_color: Color:
	get:
		return glow_color
	set(value):
		glow_color = value
		
		if _glow_sprite != null:
			(_glow_sprite.material as ShaderMaterial).set_shader_parameter('glow_color', value)

@export var _base_sprite: Sprite2D
@export var _glow_sprite: Sprite2D
@export var _damage_flash_curve: Curve
@export var _damage_flash_duration: float

var hue_shift_amount: float:
	get:
		return hue_shift_amount
	set(value):
		hue_shift_amount = value
		
		if _glow_sprite != null:
			(_glow_sprite.material as ShaderMaterial).set_shader_parameter('hue_shift_amount', value)

var expand_radius: float:
	get:
		return expand_radius
	set(value):
		expand_radius = value
		
		if _glow_sprite != null:
			(_glow_sprite.material as ShaderMaterial).set_shader_parameter('expand_radius', value)

var alpha: float:
	get:
		return alpha
	set(value):
		alpha = value
		
		if _glow_sprite != null:
			(_glow_sprite.material as ShaderMaterial).set_shader_parameter('alpha', value)

var _remaining_damage_flash_time: float

func apply_damage_flash() -> void:
	_remaining_damage_flash_time = _damage_flash_duration

func _ready() -> void:
	if expand_radius != null:
		expand_radius = 1.0
	if alpha != null:
		alpha = 1.0
	if hue_shift_amount != null:
		hue_shift_amount = 0.0

func _process(delta: float) -> void:
	if _remaining_damage_flash_time > 0.0:
		_remaining_damage_flash_time = max(_remaining_damage_flash_time - delta, 0.0)

		var time: float = 1.0 - (_remaining_damage_flash_time / _damage_flash_duration)
		var curve_min: float = _damage_flash_curve.min_value
		var curve_max: float = _damage_flash_curve.max_value
		var curve_value: float = _damage_flash_curve.sample(time)
		var curve_value_normalized: float = (curve_value - curve_min) / (curve_max - curve_min)

		(_glow_sprite.material as ShaderMaterial).set_shader_parameter('saturation', 1.0 - curve_value_normalized)
		# TODO: refactor NeonSprite component to avoid implicit behaviors (properties directly affecting uniforms)
		# (ideally an explicit shader uniform set thingy, dunno will see)
		expand_radius = curve_value


## auto-connected by sibling HealthComponent
func _on_health_took_damage() -> void:
	apply_damage_flash()
