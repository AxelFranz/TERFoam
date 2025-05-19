shader_type spatial;
//render_mode unshaded;
uniform bool printgrid = false;
uniform sampler2D uSamplerAlbedo : repeat_enable, filter_linear_mipmap;
uniform sampler2D uSamplerTransfer : repeat_disable;

//#define ANIM_TUILE
#define ANIM_ROTA
//#define ANIM_UV

vec2 hash(in ivec2 p) {
	mat2 hashMat = mat2(
		vec2(127.1, 269.5),
		vec2(311.7, 183.3)
	);

	vec2 q = hashMat * vec2(p);
	q[0] = sin(q[0]);
	q[1] = sin(q[1]);
	q *= 43758.5453;
	return vec2(q[0] - floor(q[0]), q[1] - floor(q[1]));
}

void TriangleGrid(in vec2 p_uv, inout vec3 Bi, inout ivec2 vertex1, inout ivec2 vertex2, inout ivec2 vertex3)
{
	vec2 uv = p_uv * 2.0 * sqrt(3.0);

	mat2 gridToSkewedGrid = mat2(
		vec2 (1.0, -0.57735027),
		vec2 (0.0, 01.15470054)
	);

	vec2 skewedCoord = gridToSkewedGrid * uv;
	vec2 baseId = vec2(floor(skewedCoord[0]), floor(skewedCoord[1]));
	vec3 temp = vec3(skewedCoord[0] - baseId[0], skewedCoord[1] - baseId[1], 0.0);
	temp[2] = 1.0 - temp[0] - temp[1];

	if (temp[2] > 0.0)
	{
		Bi = vec3(temp[2], temp[1], temp[0]);
		ivec2 ibaseId = ivec2(baseId);
		vertex1 = ibaseId;
		vertex2 = ibaseId + ivec2(0, 1);
		vertex3 = ibaseId + ivec2(1, 0);
	}
	else
	{
		Bi = vec3(-temp[2], 1.0 - temp[1], 1.0 - temp[0]);
		ivec2 ibaseId = ivec2(baseId);
		vertex1 = ibaseId + ivec2(1, 1);
		vertex2 = ibaseId + ivec2(1, 0);
		vertex3 = ibaseId + ivec2(0, 1);
	}
}

vec3 tiling_n_blending(vec2 uv, sampler2D tex, vec2 duvdx, vec2 duvdy) {
	vec3 B;
	ivec2 vertex1, vertex2, vertex3;
	TriangleGrid(uv, B,	vertex1, vertex2, vertex3);

	// Assign random offset to each triangle vertex
    // Hash = centre de la tuile et UV où on est
    // 3e approche : bouger uv1,2,3
    #ifdef ANIM_TUILE
    vec2 uv1 = uv + hash(vertex1) * TIME/10.f ;
	vec2 uv2 = uv + hash(vertex2) * TIME/10.f;
	vec2 uv3 = uv + hash(vertex3) * TIME/10.f;
    #else
    vec2 uv1 = uv + hash(vertex1);
	vec2 uv2 = uv + hash(vertex2);
	vec2 uv3 = uv + hash(vertex3);
    #endif
	vec3 e = textureLod(tex, uv, 100).rgb;

	vec3 t1 = textureGrad(tex, uv1, duvdx, duvdy).rgb;
    vec3 t2 = textureGrad(tex, uv2, duvdx, duvdy).rgb;
    vec3 t3 = textureGrad(tex, uv3, duvdx, duvdy).rgb;

    vec3 W = vec3(0);
	W[0] = B[0] / sqrt(B[0]*B[0] + B[1]*B[1] + B[2]*B[2]);
	W[1] = B[1] / sqrt(B[0]*B[0] + B[1]*B[1] + B[2]*B[2]);
	W[2] = B[2] / sqrt(B[0]*B[0] + B[1]*B[1] + B[2]*B[2]);
	
	if (printgrid) {
		vec3[] c = {vec3(1, 0, 0), vec3(0, 1, 0), vec3(0, 0, 1)};
		e = vec3(1.0/3.0);
		t1 = c[(vertex1.x + 2 * vertex1.y) % 3]; 
		t2 = c[(vertex2.x + 2 * vertex2.y) % 3]; 
		t3 = c[(vertex3.x + 2 * vertex3.y) % 3]; 
	}

    vec3 P = W[0] * (t1 - e) + W[1] * (t2 - e) + W[2] * (t3 - e) + e;

    return P;
}

varying vec2 UVmodif;
varying float h;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

vec2 rota(float angle, vec2 point) {
    angle = angle * PI / 180.f;
    
    mat2 rot = mat2(vec2(cos(angle),-sin(angle)),vec2(sin(angle),cos(angle)));
    
    return rot * point;
    
}

void vertex() {
	// Call.ed for every vertex the material is visible on.
#ifdef ANIM_UV
    UV.x += TIME/30.f;
#endif    
    vec2 duvdx = vec2(0.01, 0.0);
    vec2 duvdy = vec2(0.0, 0.01);
    vec2 res = tiling_n_blending(UV,uSamplerAlbedo, duvdx, duvdy).xy; // Le bruit gaussien se génère là
    res = normalize(res) * tanh(length(res));
    #ifdef ANIM_ROTA
    res = rota(TIME*360.f,res);
    #endif
    h = texture(uSamplerTransfer, res * 0.5 + 0.5).r / (2.0 * PI * 5.0);
    VERTEX.y += h;
}   

void fragment() {
    vec2 res = tiling_n_blending(UV,uSamplerAlbedo, dFdx(UV), dFdy(UV)).xy;
    res = normalize(res) * tanh(length(res));
    #ifdef ANIM_ROTA
    res = rota(TIME*360.f,res);
    #endif
    float newh = texture(uSamplerTransfer, res * 0.5 + 0.5).r / (2.0 * PI * 5.0);
    float value = tanh(newh*10.0-1.0) * 0.5 + 0.5;
    
    mat2 dUV = mat2(
        dFdx(UV),
        dFdy(UV)
    );
    vec2 dh = vec2(
        dFdx(h),
        dFdy(h)
    );
    vec2 slope = inverse(transpose(dUV)) * dh;
    NORMAL = normalize(vec3(slope.x, 1, slope.y));
    
    
    ROUGHNESS = 0.1f;
    ALBEDO = vec3(0.0);
    
    ALBEDO = mix(vec3(0,0,1),vec3(1,1,1),value) * .15; 
    //ALBEDO = vec3(value,value,value);
    //ALBEDO = vec3(0.f,0.f,h+0.1);
}
//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
