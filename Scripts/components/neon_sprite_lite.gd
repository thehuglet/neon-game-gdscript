@tool
class_name NeonSpriteLite
extends Sprite2D

@export var glow_texture: Texture2D:
	set(value):
		glow_texture = value
		_set_shader_uniform('u_glow_texture', value)
		
@export_color_no_alpha var color: Color:
	set(value):
		color = value
		_set_shader_uniform('u_color', value)
		_update_base_color(glow_color_on_base)

@export var alpha_multiplier: float = 1.0:
	get:
		return alpha_multiplier
	set(value):
		alpha_multiplier = value
		_set_shader_uniform('u_alpha_multiplier', value)

@export var glow_color_on_base: bool = false:
	get:
		return glow_color_on_base
	set(value):
		glow_color_on_base = value
		_update_base_color(value)

var do_glow_alpha_multiplier: bool = true

func _ready() -> void:
	_update_base_color(glow_color_on_base)
	_set_shader_uniform('u_do_glow_alpha_multiplier', do_glow_alpha_multiplier)

func _set_shader_uniform(uniform_name: String, value: Variant) -> void:
	(material as ShaderMaterial).set_shader_parameter(uniform_name, value)

func _update_base_color(is_base_as_glow_color: bool) -> void:
	var color_options: Array[Color] = [Color.WHITE, color]
	_set_shader_uniform('u_base_color', color_options[is_base_as_glow_color as int])

# @export_category('References')
# @export var _glow_sprite: Sprite2D

# @onready var blurred_mat: ShaderMaterial = _glow_sprite.material
	# _glow_sprite.texture = glow_texture
	# blurred_mat.set_shader_parameter('u_color', color)
