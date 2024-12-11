shader_type canvas_item;
render_mode blend_add;

uniform sampler2D u_glow_texture;
uniform vec3 u_base_color : source_color;
uniform vec3 u_color : source_color;
uniform float u_alpha_multiplier = 1.0;
uniform bool u_do_glow_alpha_multiplier;

const float ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	vec4 glow_color = texture(u_glow_texture, UV);

	base_color.rgb = u_base_color;

	glow_color.rgb = u_color;

	if (u_do_glow_alpha_multiplier) {
		glow_color.a *= ALPHA_MULTIPLIER;
	}

	vec4 final_color = mix(glow_color, base_color, base_color.a);
	final_color.a *= u_alpha_multiplier;
	COLOR = final_color;
}
