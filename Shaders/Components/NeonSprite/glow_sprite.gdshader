shader_type canvas_item;
render_mode blend_add;

#include "res://Shaders/ShaderIncludes/hsv.gdshaderinc"

uniform vec3 color : source_color;
uniform float alpha = 1.0;
uniform float expand_radius = 0.0;
uniform float hue_shift = 0.0;
uniform float saturation = 1.0;
uniform float brightness = 1.0;

const float BASE_ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 rgb_color = texture(TEXTURE, UV);

	// RGBA operations
	rgb_color.a *= alpha * (expand_radius + 1.0) * BASE_ALPHA_MULTIPLIER;
	rgb_color.rgb = color;

	// HSV operations | [0] Hue; [1] Saturation; [2] Brightness;
	vec4 hsv_color = rgb2hsv(rgb_color);
	hsv_color[0] += hue_shift;
	hsv_color[1] *= saturation;
	hsv_color[2] *= brightness;

	COLOR = vec4(hsv2rgb(hsv_color));
}
