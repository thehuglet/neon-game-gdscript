shader_type canvas_item;
render_mode blend_add;

uniform vec3 color : source_color;

const float BASE_ALPHA_MULTIPLIER = 2.5;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = vec4(color.rgb, col.a * BASE_ALPHA_MULTIPLIER);
}
