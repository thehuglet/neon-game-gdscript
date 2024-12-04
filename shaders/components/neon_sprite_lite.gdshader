shader_type canvas_item;
render_mode blend_add;

uniform sampler2D u_glow_texture;
uniform vec3 u_color : source_color;
uniform float u_alpha_multiplier = 1.0;

const float BASE_ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	vec4 glow_color = texture(u_glow_texture, UV);

	glow_color.rgb = u_color;
	glow_color.a *= BASE_ALPHA_MULTIPLIER * u_alpha_multiplier;

	vec4 final_color = mix(glow_color, base_color, base_color.a);
	COLOR = final_color;
}
