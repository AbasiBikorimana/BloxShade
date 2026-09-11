#version 120

#define DRAW_SHADOW_MAP gcolor //Configures which buffer to draw to the screen [gcolor shadowcolor0 shadowtex0 shadowtex1]\

#include "lib/settings.glsl"
#include "lib/color_adjustments.glsl"

uniform float frameTimeCounter;
uniform sampler2D gcolor;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

varying vec2 texcoord;


void main() {
	vec3 color = texture2D(DRAW_SHADOW_MAP, texcoord).rgb;
	
	color = make_green(color, GREEN_AMOUNT);
	color = make_blue(color, BLUE_AMOUNT);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}