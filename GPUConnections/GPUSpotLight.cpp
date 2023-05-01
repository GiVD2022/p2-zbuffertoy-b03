#include "GPUSpotLight.hh"

GPUSpotLight::GPUSpotLight(vec3 pos, vec3 dir, vec3 Ia, vec3 Id, vec3 Is, float a, float b, float c, float angle) :
    SpotLight(pos, dir, Ia, Id, Is, a, b, c, angle)
{

}

void GPUSpotLight::toGPU(shared_ptr<QGLShaderProgram> p) {
    GPULight::toGPU(p);
}

vec3 GPUSpotLight::vectorL(vec3 point) {
    return SpotLight::vectorL(point);
}

float GPUSpotLight::attenuation(vec3 point) {
    return SpotLight::attenuation(point);
}

float GPUSpotLight::distanceToLight(vec3 point) {
    return SpotLight::distanceToLight(point);
}
