shader_type spatial;
render_mode blend_mix, depth_draw_always, cull_back, unshaded;

group_uniforms textures;

uniform sampler2D albedo_texture;

group_uniforms color;

uniform float opacity : hint_range(0.0, 1.0) = 0.35;
instance uniform vec4 start_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
instance uniform vec4 end_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

varying vec4 screen_pos;

vec4 change_color_over_time(vec3 normal, vec3 view, vec2 uv) {
	float color_r = smoothstep(end_color.r, start_color.r, TIME);
	float color_g = smoothstep(end_color.g, start_color.g, TIME);
	float color_b = smoothstep(end_color.b, start_color.b, TIME);
	
	vec4 base_texture = texture(albedo_texture, uv);
	vec3 base_color = base_texture.rgb * vec3(color_g, color_r, color_b);
    
	vec4 final_color = vec4(base_color, start_color.a);

	float final_alpha = start_color.a * opacity;
	final_color.a = clamp(final_alpha, 0.0, 1.0);
	return final_color;
}


void vertex() {
    screen_pos = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
}

void fragment() {
    vec4 final_colour = change_color_over_time(NORMAL, VIEW, UV);


    EMISSION = final_colour.rgb;
    ALBEDO = final_colour.rgb;
    ALPHA = final_colour.a;
}
