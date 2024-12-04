@tool
class_name NeonSpriteLite
extends Sprite2D

@export var _glow_texture: Texture2D:
	set(value):
		_glow_texture = value
		_set_shader_uniform('u_glow_texture', value)
		
@export_color_no_alpha var _color: Color:
	set(value):
		_color = value
		_set_shader_uniform('u_color', value)

@export var alpha_multiplier: float = 1.0:
	set(value):
		alpha_multiplier = value
		_set_shader_uniform('u_alpha_multiplier', value)

func _set_shader_uniform(uniform_name: String, value: Variant) -> void:
	(material as ShaderMaterial).set_shader_parameter(uniform_name, value)

# @export_category('References')
# @export var _glow_sprite: Sprite2D

# @onready var blurred_mat: ShaderMaterial = _glow_sprite.material
	# _glow_sprite.texture = _glow_texture
	# blurred_mat.set_shader_parameter('u_color', _color)
