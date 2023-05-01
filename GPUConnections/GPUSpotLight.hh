#pragma once

#include "GPUConnections/GPULight.hh"
#include "Model/Modelling/Lights/SpotLight.hh"

class GPUSpotLight : public GPULight, public SpotLight {
public:
    GPUSpotLight() {}
    /*
     * Constructor de la classe SpotLight.
     * param pos: posició de la llum.
     * param dir: direcció en la que apunta la llum.
     * param Ia: component ambient de la llum.
     * param Id: component difosa de la llum.
     * param Is: component especular de la llum.
     * param a: coeficient a de l'atenuacio.
     * param b: coeficient b de l'atenuacio.
     * param c: coeficient c de l'atenuacio.
     * param angle: angle d'obertura de la llum.
     * */
    GPUSpotLight(vec3 pos, vec3 dir, vec3 Ia, vec3 Id, vec3 Is, float a, float b, float c, float angle);
    virtual ~GPUSpotLight() {}

    virtual void toGPU(shared_ptr<QGLShaderProgram> p) override;
    virtual vec3 vectorL(vec3 point) override;
    virtual float attenuation(vec3 point) override;
    virtual float distanceToLight(vec3 point) override;

};

