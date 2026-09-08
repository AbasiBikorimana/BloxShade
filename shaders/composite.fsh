#version 120

#define DRAW_SHADOW_MAP gcolor //Configures which buffer to draw to the screen [gcolor shadowcolor0 shadowtex0 shadowtex1]\

#define BLUE_AMOUNT 0.0 //[0.0 0.25 0.5 0.75 1.0]
#define GREEN_AMOUNT 0.0 //[0.0 0.25 0.5 0.75 1.0]
#define GREY_AMOUNT 0.0 //[0.0 0.25 0.5 0.75 1.0]

uniform float frameTimeCounter;
uniform sampler2D gcolor;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

varying vec2 texcoord;

vec3 make_green(in vec3 color, in float amount)
{
	return mix(color, vec3(0.,1.,0.), amount);
}

vec3 make_blue(in vec3 color, in float amount)
{
	return mix(color, vec3(0.,0.,1.), amount);
}

void main() {
	vec3 color = texture2D(DRAW_SHADOW_MAP, texcoord).rgb;

	color = make_green(color, GREEN_AMOUNT);
	color = make_blue(color, BLUE_AMOUNT);

	float average_color = (color.r + color.g + color.b) / 3.0;
	color = mix(color, vec3(average_color), GREY_AMOUNT);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}