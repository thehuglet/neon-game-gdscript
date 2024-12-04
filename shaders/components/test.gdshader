shader_type canvas_item;

uniform sampler2D u_base_texture;
uniform sampler2D u_glow_texture;
uniform vec3 u_color : source_color = vec3(1.0, 1.0, 1.0);
//uniform float texture_2_opacity = 1.0; // How transparent the second texture should be

void fragment() {
	// Sample both textures
	vec4 base_color = texture(u_base_texture, UV);
	vec4 glow_color = texture(u_glow_texture, UV);

	glow_color.rgb = u_color;

	// Combine textures (alpha blending texture 2 over texture 1)
	vec4 final_color = mix(glow_color, base_color, base_color.a);

	COLOR = final_color;
}