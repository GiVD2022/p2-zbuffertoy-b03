#include "GPUDirectionalLight.hh"

GPUDirectionalLight::GPUDirectionalLight(vec3 dir, vec3 Ia, vec3 Id, vec3 Is) :
    DirectionalLight(dir, Ia, Id, Is)
{

}

void GPUDirectionalLight::toGPU(shared_ptr<QGLShaderProgram> p) {
    GPULight::toGPU(p); // Crida al mètode toGPU() de la classe base
}

// La direcció de la llum no influeix en el vector L
vec3 GPUDirectionalLight::vectorL(vec3 point) {
    return normalize(getDir());
}

// La llum direccional no té atenuació
float GPUDirectionalLight::attenuation(vec3 point) {
    return 1.0;
}

float GPUDirectionalLight::distanceToLight(vec3 point) {
    return 1.0e+38; // Valor suficientment alt per considerar que la llum és a l'infinit
}
