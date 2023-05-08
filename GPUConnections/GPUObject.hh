#ifndef GPUOBJECT_H
#define GPUOBJECT_H
#include "Model/Modelling/Objects/Object.hh"
#include "GPUConnections/GPUConnectable.hh"
#include "GPUConnections/GPUMaterial.hh"

class GPUObject: public Object, public GPUConnectable{
public:
    GPUObject();
    virtual ~GPUObject() {};
    virtual void toGPU(shared_ptr<QGLShaderProgram> p) override;
    virtual void draw() override;

    // Metodes a implementar en les classes filles: son  metodes abstractes
    virtual bool hit(Ray& r, float tmin, float tmax, HitInfo& info) const override = 0;
    virtual void aplicaTG(shared_ptr<TG>) override = 0 ;

    // OPCIONAL: Mètode que retorna totes les interseccions de l'objecte
    //    virtual bool allHits(const Ray& r, vector<shared_ptr<HitInfo> infos) const = 0;

    virtual void read (const QJsonObject &json) override{};
    virtual void write(QJsonObject &json) const override{};
    virtual void print(int indentation) const override{};


private:

    shared_ptr<GPUMaterial> material;
};





#endif // GPUOBJECT_H
