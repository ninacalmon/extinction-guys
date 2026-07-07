shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius = 0.35;
uniform float softness = 0.15;
uniform float strength = 0.003;

void fragment() {
    vec2 uv = SCREEN_UV;

    float dist = distance(uv, center);
    float blur = smoothstep(radius, radius + softness, dist);

    vec2 s = vec2(strength * blur);

    vec4 col = vec4(0.0);

    // Center
    col += texture(screen_texture, uv) * 4.0;

    // Cardinal directions
    col += texture(screen_texture, uv + vec2( s.x, 0.0));
    col += texture(screen_texture, uv + vec2(-s.x, 0.0));
    col += texture(screen_texture, uv + vec2(0.0,  s.y));
    col += texture(screen_texture, uv + vec2(0.0, -s.y));

    // Diagonals
    col += texture(screen_texture, uv + vec2( s.x,  s.y));
    col += texture(screen_texture, uv + vec2(-s.x,  s.y));
    col += texture(screen_texture, uv + vec2( s.x, -s.y));
    col += texture(screen_texture, uv + vec2(-s.x, -s.y));

    COLOR = col / 12.0;
}