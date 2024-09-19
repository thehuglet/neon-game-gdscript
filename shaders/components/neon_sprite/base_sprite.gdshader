shader_type canvas_item;
render_mode blend_add;

uniform float u_alpha = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.a *= u_alpha;
	COLOR = vec4(color);
}