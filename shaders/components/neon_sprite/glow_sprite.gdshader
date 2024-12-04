shader_type canvas_item;
render_mode blend_add;

#include "res://shaders/includes/hsv.gdshaderinc"

uniform vec3 u_color : source_color;
uniform float u_alpha = 1.0;
uniform float u_expand_radius = 0.0;
uniform float u_hue_shift = 0.0;
uniform float u_saturation = 1.0;
uniform float u_brightness = 1.0;
uniform float u_damage_flash_factor = 0.0;

const float BASE_ALPHA_MULTIPLIER = 2.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	// RGB operations
	color.a *= u_alpha * (u_expand_radius + 1.0) * BASE_ALPHA_MULTIPLIER;
	color.rgb = u_color;

	// HSV operations | [0] Hue; [1] Saturation; [2] Brightness;
	vec4 hsva_color = rgb2hsv(color);
	hsva_color[0] += u_hue_shift;
	hsva_color[1] *= u_saturation * 1.2;
	hsva_color[2] *= u_brightness;

	// Final RGB adjustments
	color = hsv2rgb(hsva_color);
	color.rgb = mix(color.rgb, vec3(1.0), u_damage_flash_factor);
	color.a *= u_damage_flash_factor * 4.0 + 1.0;

	COLOR = color;
}
