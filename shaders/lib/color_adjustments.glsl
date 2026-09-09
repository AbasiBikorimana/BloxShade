//color adjustments

vec3 make_green(in vec3 color, in float amount)
{
	return mix(color, vec3(0.,1.,0.), amount);
}

vec3 make_blue(in vec3 color, in float amount)
{
	return mix(color, vec3(0.,0.,1.), amount);
}

vec3 greyscale(in vec3 color, in float amount)
{
	float average_color = (color.r + color.g + color.b) / 3.0;
	return color = mix(color, vec3(average_color), amount);
}
