#version 120

#include "lib/settings.glsl"
#include "lib/PerlinNoise.glsl"

uniform float frameTimeCounter;
uniform sampler2D colortex0;
uniform sampler2D depthtex0;

varying vec2 texcoord;

float random(in vec2 p)
{
	return fract(sin(p.x * 734.0 + p.y * 54.0) * 100.0);
}

vec2 smoothv2(in vec2 v)
{
	return v*v*(3.0 - 2.0 * v);
}
float smooth_noise(in vec2 p)
{
	vec2 f = smoothv2(fract(p));
	float a = random(floor(p));
	float b = random(vec2(ceil(p.x), floor(p.y)));
	float c = random(vec2(floor(p.x), ceil(p.y)));
	float d = random(ceil(p));

	return mix(mix(a,b,f.x), mix(c,d,f.x), f.y);
}

float fractual_noise(in vec2 p)
{
	float total = 0.5;
	float amplitude = 1.0;
	float frequency = 1.0;
	float iterations = 4;

	for(float i = 0; i < iterations; i++)
	{
		total += (smooth_noise(p * frequency) -0.5) * amplitude;
		amplitude *= 0.5;
		frequency *= 2.0;
	}
	return total;
}
void main() {
	vec3 color = texture2D(colortex0, texcoord).rgb;
	float depth = texture2D(depthtex0, texcoord).r;

	if (depth == 1)
	{
		vec2 uv = texcoord * 10.0;
		vec2 uv2 = texcoord * 30.0 + frameTimeCounter * 0.1;

		color.rgb += vec3(fractual_noise(uv) * fractual_noise(uv2));
	}





/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}