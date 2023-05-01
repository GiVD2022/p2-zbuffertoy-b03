#include "GPUConnections/GPUPointLight.hh"

GPUPointLight::GPUPointLight(vec3 posicio, vec3 Ia, vec3 Id, vec3 Is, float a, float b, float c): PointLight(posicio, Ia, Id, Is, a, b, c) {
}

void GPUPointLight::toGPU(shared_ptr<QGLShaderProgram> p) {
    // TO DO Pràctica 2: Fase 1: enviar les llums a la GPU
    //N6, com ja agafem posició i direcció, cridar al toGPU de GPUlight es suficient
    GPULight::toGPU(p); // Crida al mètode toGPU() de la classe base
}


vec3 GPUPointLight::vectorL(vec3 point) {
    return PointLight::vectorL(point);
}

float GPUPointLight::attenuation(vec3 point) {
    return PointLight::attenuation(point);
}

float GPUPointLight::distanceToLight(vec3 point) {
    return PointLight::distanceToLight(point);
}
