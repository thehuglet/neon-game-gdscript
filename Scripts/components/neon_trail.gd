class_name NeonTrail
extends Node2D

@export var enabled: bool = true

@export_group('Parameters')
@export_range(0.0, 10.0, 0.1) var _rgb_overdrive_factor: float
@export var spawn_interval_sec: float
@export var _decay_time: float
@export var _base_alpha: float

@export_group('Textures')
@export var _texture: Texture2D
@export var _glow_texture: Texture2D

@export_group('Over-Time Effects')
@export var _alpha_curve: Curve
@export var _scale: Curve
@export var _gradient: GradientTexture1D
@export_group('')

@export var _neon_sprite_lite_scene: PackedScene

var _spawn_timer: float
var _current_rotation: float
var _base_segment_scale: float = 0.6
var _segments: Array[NeonSpriteLite]
var _segment_ages: Array[float]

func _process(delta: float) -> void:
	for i in range(_segments.size() - 1, -1, -1):
		_segment_ages[i] += delta

		# _segments[i].alpha_multiplier -= delta / _decay_time * _base_alpha
		# _segments[i].alpha_multiplier = clamp(_segments[i].alpha_multiplier, 0.0, 1.0)

		var normalized_value: float = _segment_ages[i] / _decay_time if _decay_time > 0 else 0.0

		if _alpha_curve != null:
			_segments[i].alpha_multiplier = _base_alpha * clamp(_alpha_curve.sample(normalized_value), 0.0, 1.0)

		if _gradient != null:
			var current_color: Color = _gradient.gradient.sample(normalized_value)
			_segments[i].color = _overdrive_color(current_color, _rgb_overdrive_factor + 1)
		if _scale != null:
			var segment_scale: float = _base_segment_scale * _scale.sample(normalized_value)
			_segments[i].scale = Vector2(segment_scale, segment_scale)

		if _segment_ages[i] >= _decay_time:
			_segments[i].queue_free()
			_segments.pop_at(i)
			_segment_ages.pop_at(i)

	if not enabled:
		return

	_spawn_timer += delta
	if _spawn_timer < spawn_interval_sec:
		return

	_spawn_timer = 0.0
	var segment: NeonSpriteLite = _spawn_trail_segment()

	_segments.append(segment)
	_segment_ages.append(0.0)

func update_rotation(value_radians: float) -> void:
	_current_rotation = value_radians

func _spawn_trail_segment() -> NeonSpriteLite:
	var inst: NeonSpriteLite = _neon_sprite_lite_scene.instantiate()
	inst.texture = _texture
	inst.glow_texture = _glow_texture
	inst.color = _overdrive_color(_gradient.gradient.sample(0.0), _rgb_overdrive_factor + 1.0)
	inst.alpha_multiplier = _base_alpha

	inst.do_glow_alpha_multiplier = false
	inst.glow_color_on_base = true
	inst.scale = Vector2(_base_segment_scale, _base_segment_scale)
	inst.z_index = -3
	inst.top_level = true
	inst.position = global_position
	inst.rotation = _current_rotation

	add_child(inst)
	return inst

func _overdrive_color(color: Color, multiplier: float) -> Color:
	color.r *= multiplier
	color.g *= multiplier
	color.b *= multiplier
	return color
