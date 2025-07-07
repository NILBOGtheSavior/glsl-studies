#ifdef GL_ES
precision mediump float;
#endif

/*
Shader Rainbow
NILBOGtheSavior

This is a shader that draws a ROYGBIV rainbow on the screen.

*/

uniform vec2 u_resolution;

vec3 red = vec3(1., 0., 0.);
vec3 orange = vec3(1., 0.5, 0.);
vec3 yellow = vec3(1., 1., 0.);
vec3 green = vec3(0., 1., 0.);
vec3 blue = vec3(0., 0., 1.);
vec3 indigo = vec3(1., 0., 1.);
vec3 violet = vec3(0.5, 0.5, 1.);

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;

    vec3 color = vec3(0.);

    float r = 1. - smoothstep(0., 0.15, uv.x);
    float o = smoothstep(0.00, 0.15, uv.x) * (1. - smoothstep(0.15, 0.3, uv.x));
    float y = smoothstep(0.15, 0.3, uv.x) * (1. - smoothstep(0.3, 0.45, uv.x));
    float g = smoothstep(0.3, 0.45, uv.x) * (1. - smoothstep(0.45, 0.6, uv.x));
    float b = smoothstep(0.45, 0.6, uv.x) * (1. - smoothstep(0.6, 0.75, uv.x));
    float i = smoothstep(0.6, 0.75, uv.x) * (1. - smoothstep(0.75, 0.1, uv.x));
    float v = smoothstep(0.75, 1., uv.x);

    color = red * r + orange * o + yellow * y + green * g + blue * b + indigo * i + violet * v;

    gl_FragColor = vec4(color, 1.);
}