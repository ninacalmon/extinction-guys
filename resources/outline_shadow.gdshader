shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_size = 1.0;

uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform vec2 shadow_offset = vec2(2.0, 2.0);

void fragment() {
    vec2 texel = TEXTURE_PIXEL_SIZE;

    vec4 center = texture(TEXTURE, UV);

    // Shadow
    vec4 shadow = texture(TEXTURE, UV - shadow_offset * texel);

    // Outline
    float outline = 0.0;

    outline += texture(TEXTURE, UV + vec2( outline_size, 0.0) * texel).a;
    outline += texture(TEXTURE, UV + vec2(-outline_size, 0.0) * texel).a;
    outline += texture(TEXTURE, UV + vec2(0.0,  outline_size) * texel).a;
    outline += texture(TEXTURE, UV + vec2(0.0, -outline_size) * texel).a;

    outline += texture(TEXTURE, UV + vec2( outline_size,  outline_size) * texel).a;
    outline += texture(TEXTURE, UV + vec2(-outline_size,  outline_size) * texel).a;
    outline += texture(TEXTURE, UV + vec2( outline_size, -outline_size) * texel).a;
    outline += texture(TEXTURE, UV + vec2(-outline_size, -outline_size) * texel).a;

    outline = clamp(outline, 0.0, 1.0);

    vec4 color = center;

    // Draw outline behind text
    color = mix(color, outline_color, outline * (1.0 - center.a));

    // Draw shadow behind both
    color = mix(color, shadow_color, shadow.a * (1.0 - color.a));

    COLOR = color;
}