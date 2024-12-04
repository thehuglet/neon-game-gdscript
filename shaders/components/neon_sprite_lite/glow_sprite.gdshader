shader_type canvas_item;
render_mode blend_add;

uniform vec3 u_color : source_color;
uniform float u_alpha_multiplier = 1.0;

const float BASE_ALPHA_MULTIPLIER = 5.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = vec4(u_color.rgb, col.a * BASE_ALPHA_MULTIPLIER * u_alpha_multiplier);
}
