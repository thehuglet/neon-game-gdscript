shader_type canvas_item;
render_mode blend_add;

uniform float alpha = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	color.a *= alpha;

	COLOR = vec4(color);
}
