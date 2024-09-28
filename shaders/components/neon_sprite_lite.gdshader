shader_type canvas_item;
render_mode blend_add;

uniform sampler2D u_glow_texture;
uniform vec3 u_color : source_color;

const float BASE_ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	vec4 glow_color = texture(u_glow_texture, UV);
	
	glow_color.rgb = u_color;

	// base_color.a *= 1.25;
	glow_color.a *= BASE_ALPHA_MULTIPLIER;

	vec4 final_color = mix(glow_color, base_color, base_color.a);
	//vec4 final_color.a = base_color.a + glow_color.a;
	
	//final_color.rgb += base_color.rgb;
	
	COLOR = final_color;
	//COLOR = base_color;
	// vec4 color = texture(TEXTURE, UV);
	
	// COLOR = vec4(u_color.rgb, col.a * BASE_ALPHA_MULTIPLIER);
}
