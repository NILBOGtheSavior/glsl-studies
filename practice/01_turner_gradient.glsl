#ifdef GL_ES
precision mediump float;
#endif

/*
Turner Gradient
NILBOGtheSavior

This is a gradient based on the painting by William Turner, 'The Fighting Temeraire'. sin(u_time) to blend between the day and night cycle.

*/

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 col1 = vec3(0.3451, 0.4196, 0.7608);
vec3 col2 = vec3(0.0, 0.098, 0.3059);
vec3 col3 = vec3(0.91, 0.2, 0.07);
vec3 col4 = vec3(0.0549, 0.0275, 0.1882);

float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 uv = st.yx;

    vec3 color = vec3(0.0);

    vec3 sky_grad = vec3(1. - pow(max(0., abs(uv.x) * 2. - .5) , .5));

    // Sky

    vec3 day_sky = mix(col1, col3, sky_grad);
    vec3 night_sky = mix(col2, col4, sky_grad);

    vec3 sky = mix (day_sky, night_sky, sin(u_time / 4.) / 2.);

    // Sun

    vec2 sun_pos = vec2(0.8, 0.4);
    float sun_rad = distance(uv, sun_pos);
    vec3 sun_color = vec3(1.0, 0.6, 0.0);
    float sun = 1. - smoothstep(0., 0.4, sun_rad);

    // vec3 sand = vec3(1., 0., 1.);

    color += sky;
    color += sun * sun_color * .5;
    gl_FragColor = vec4(color,1.0);
}
