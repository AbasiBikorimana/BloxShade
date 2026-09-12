vec2 randomGradient(vec2 p)
{
    float angle = fract(
        sin(dot(p, vec2(127.1, 311.7))) * 43758.5453
    ) * 6.2831853;

    return vec2(cos(angle), sin(angle));
}

float fade(float t)
{
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

float PerlinNoise(vec2 p)
{
    // Bottom-left corner of the grid cell
    vec2 cell = floor(p);

    // Position inside the cell: 0..1
    vec2 local = fract(p);

    // Gradients at the 4 corners
    vec2 g00 = randomGradient(cell + vec2(0.0, 0.0));
    vec2 g10 = randomGradient(cell + vec2(1.0, 0.0));
    vec2 g01 = randomGradient(cell + vec2(0.0, 1.0));
    vec2 g11 = randomGradient(cell + vec2(1.0, 1.0));

    // Vectors from each corner to p
    vec2 d00 = local - vec2(0.0, 0.0);
    vec2 d10 = local - vec2(1.0, 0.0);
    vec2 d01 = local - vec2(0.0, 1.0);
    vec2 d11 = local - vec2(1.0, 1.0);

    // Gradient · displacement
    float n00 = dot(g00, d00);
    float n10 = dot(g10, d10);
    float n01 = dot(g01, d01);
    float n11 = dot(g11, d11);

    // Smooth interpolation weights
    vec2 u = vec2(fade(local.x), fade(local.y));

    // Interpolate along X
    float nx0 = mix(n00, n10, u.x);
    float nx1 = mix(n01, n11, u.x);

    // Interpolate those results along Y
    return mix(nx0, nx1, u.y);
}