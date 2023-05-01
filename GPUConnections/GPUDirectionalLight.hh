#pragma once

#include "GPUConnections/GPULight.hh"
#include "Model/Modelling/Lights/DirectionalLight.hh"

class GPUDirectionalLight : public GPULight, public DirectionalLight {
public:
    GPUDirectionalLight() {};
    /*
     * Constructor de la classe DirectionalLight.
     * param dir: direcció en la que apunta la llum.
     * param Ia: component ambient de la llum.
     * param Id: component difosa de la llum.
     * param Is: component especular de la llum.
     * */
    GPUDirectionalLight(vec3 dir, vec3 Ia, vec3 Id, vec3 Is);
    virtual ~GPUDirectionalLight() {}

    virtual void toGPU(shared_ptr<QGLShaderProgram> p) override;
    virtual vec3 vectorL(vec3 point) override;
    virtual float attenuation(vec3 point) override;
    virtual float distanceToLight(vec3 point) override;

};
