class_name NeonSpriteLiteComponent
extends Sprite2D

@export var _blurred_texture: Texture2D
@export_color_no_alpha var color: Color
@export var _blurred_sprite: Sprite2D

var blurred_mat: ShaderMaterial:
	get:
		return blurred_mat
	set(value):
		blurred_mat = value

func _ready() -> void:
	_blurred_sprite.texture = _blurred_texture
	blurred_mat = _blurred_sprite.material as ShaderMaterial
	blurred_mat.set_shader_parameter('color', color)

func _process(delta: float) -> void:
	pass
