class_name NeonSpriteLite
extends Sprite2D

@export var _glow_texture: Texture2D
@export_color_no_alpha var _color: Color

@export_category('References')
@export var _glow_sprite: Sprite2D

@onready var blurred_mat: ShaderMaterial = _glow_sprite.material

func _ready() -> void:
	_glow_sprite.texture = _glow_texture
	blurred_mat.set_shader_parameter('u_color', _color)
