#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

float plot(vec2 uv, float pct){
  return  step( pct-0.01, uv.y) -
          step( pct+0.01, uv.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution * 2. - 1.;

    float deg = u_mouse.x / u_resolution.x * 3. + 0.5; // Sets degree on a scale of 0.5 - 3.5 based on mouse x coord

    float x = sin(uv.x);

    float pulse = 1. - pow(abs(x), deg);
    float spike = pow(cos(PI * x/2.), deg);
    float bell = 1. - pow(abs(sin(PI * x/2.)), deg);
    float flat_top = pow(min(1. - abs(x), cos(PI * x/2.)), deg);
    float wave = pow(1. - max(0., abs(x) * 2. - 1.) , deg);

    float pct_pulse = plot(uv,pulse);
    float pct_spike = plot(uv, spike);
    float pct_bell = plot(uv, bell);
    float pct_flat_top = plot(uv, flat_top);
    float pct_wave = plot(uv, wave);

    vec3 color = vec3(u_mouse.x / u_resolution.x) / 4.;

    color = (1.0-pct_pulse)*color+pct_pulse*vec3(0.,1.,0.);
    color = (1.0-pct_spike)*color+pct_spike*vec3(1.,0.,0.);
    color = (1.0-pct_bell)*color+pct_bell*vec3(0.,0.,1.);
    color = (1.0-pct_flat_top)*color+pct_flat_top*vec3(1.,0.,1.);
    color = (1.0-pct_wave)*color+pct_wave*vec3(1.,1.,0.);

    gl_FragColor = vec4(color,1.0);
}