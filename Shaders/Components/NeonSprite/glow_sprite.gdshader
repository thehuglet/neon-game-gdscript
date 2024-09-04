shader_type canvas_item;
render_mode blend_add;

#include "res://Shaders/ShaderIncludes/hsv.gdshaderinc"

// TODO: change uniform names to 'hue_shift_amount' -> 'hue_shift' and 'saturation' -> 'saturation_shift'
// TODO: change expand radius to start from 0.0 rather than 1.0 ('+ 1.0' during calculations)

uniform vec3 glow_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float alpha = 1.0;
uniform float saturation = 1.0;
uniform float expand_radius = 1.0;
uniform float hue_shift_amount = 0.0;

const float BASE_ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 rgb_color = texture(TEXTURE, UV);

	// RGBA operations
	rgb_color.a *= alpha * expand_radius * BASE_ALPHA_MULTIPLIER;
	rgb_color.rgb = glow_color;

	// HSV operations | [0] Hue; [1] Saturation; [2] Brightness;
	vec4 hsv_color = rgb2hsv(rgb_color);
	hsv_color[0] += hue_shift_amount;
	hsv_color[1] *= saturation;

	COLOR = vec4(hsv2rgb(hsv_color));
}
