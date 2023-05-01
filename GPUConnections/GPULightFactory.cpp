#include "GPUConnections/GPULightFactory.hh"


//! createLight

// TODO: Pràctica 2: Fase 1: Incloure els diferents tipus de llum
shared_ptr<GPULight> GPULightFactory::createLight( LightFactory::LIGHT_TYPES t) {
    shared_ptr<GPULight> l;
    switch(t) {
    case LightFactory::LIGHT_TYPES::POINTLIGHT:
        l = make_shared<GPUPointLight>();
        break;
    case LightFactory::LIGHT_TYPES::DIRECTIONALLIGHT:
        l = make_shared<GPUDirectionalLight>();
        break;

    case LightFactory::LIGHT_TYPES::SPOTLIGHT:
        l = make_shared<GPUSpotLight>();
        break;

    default:
        break;
    }
    return l;
}
shared_ptr<GPULight> GPULightFactory::createLight(vec3 posicio, vec3 dir, vec3 Ia, vec3 Id, vec3 Is, float a, float b, float c, float angle, LightFactory::LIGHT_TYPES t) {
    shared_ptr<GPULight> l;
    switch(t) {
    case LightFactory::LIGHT_TYPES::POINTLIGHT:
        l = make_shared<GPUPointLight>(posicio, Ia, Id, Is, a, b, c);
        break;

    case LightFactory::LIGHT_TYPES::DIRECTIONALLIGHT:
        l = make_shared<GPUDirectionalLight>(dir, Ia, Id, Is);
        break;

    case LightFactory::LIGHT_TYPES::SPOTLIGHT:
        l = make_shared<GPUSpotLight>(posicio,dir, Ia, Id, Is, a, b, c, angle);
        break;

    default:
        break;
    }
    return l;
}
