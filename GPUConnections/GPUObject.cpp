#include "GPUObject.hh"

void GPUObject::toGPU(shared_ptr<QGLShaderProgram> p){
    this->material->toGPU(p);
}

void GPUObject::draw(){

}
