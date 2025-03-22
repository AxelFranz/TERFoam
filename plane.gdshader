shader_type spatial;

uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
   VERTEX.z += 0.1*texture(tex,UV).x;
}

void fragment() {
	// Called for every pixel the material is visible on.
    ALBEDO = vec3(1.f,1.f,1.f);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
