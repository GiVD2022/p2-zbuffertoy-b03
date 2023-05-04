#pragma once

#include "GPUConnections/GPUConnectable.hh"
#include "Model/Modelling/Materials/Material.hh"

using namespace std;

class GPUMaterial: public Material, public GPUConnectable {

public:
    GPUMaterial(vec3 Ka, vec3 Kd, vec3 Ks, float shiness, float opacity);
    GPUMaterial();
    virtual ~GPUMaterial() {};

    virtual void toGPU(shared_ptr<QGLShaderProgram> p) override;
    virtual bool scatter(const Ray& r_in, const HitInfo& rec, vec3& color, Ray & r_out) const override;
    virtual vec3 getDiffuse(vec2 point) const override;   //Calcula el factor d'atenuacio de la llum al punt passat per parametre
    virtual void draw() override;
    virtual void read (const QJsonObject &json) override;
    virtual void write(QJsonObject &json) const override;
    virtual void print(int indentation) const override;

private:
    //My atributes (N6) (i si, ha de ser un struct perque ho demanen)
    struct gl_materials{
       GLuint glKd;
       GLuint glKa;
       GLuint glKs;
       GLuint glShiness;
       GLuint glOpacity;
    };
    gl_materials gl_my_materials[5];


};

