#include "GPUConnections/GPUPointLight.hh"

GPUPointLight::GPUPointLight(vec3 Ia, vec3 Id, vec3 Is, vec3 abc, vec4 pos): PointLight(Ia, Id, Is, abc, pos) {

}

void GPUPointLight::toGPU(shared_ptr<QGLShaderProgram> p) {
    qDebug() << "PointLights toGPU.....";
    program = p;
    int index;

    index = PointLight::getIndex();

    // Obtenir ubis de les variables del Shader
    gl_my_pointLights[index].glIa = program->uniformLocation("myPointLights.Ia");
    gl_my_pointLights[index].glId = program->uniformLocation("myPointLights.Id");
    gl_my_pointLights[index].glIs = program->uniformLocation("myPointLights.Is");
    gl_my_pointLights[index].glABC = program->uniformLocation("myPointLights.abc");
    gl_my_pointLights[index].glPos = program->uniformLocation("myPointLights.pos");

    qDebug() << "PointLights toGPU2.....";

    // Enviar valors a GPU
    glUniform3fv(gl_my_pointLights[index].glIa, 1, this->PointLight::getIa());
    glUniform3fv(gl_my_pointLights[index].glId, 1, this->PointLight::getId());
    glUniform3fv(gl_my_pointLights[index].glIs, 1, this->PointLight::getIs());
    glUniform3fv(gl_my_pointLights[index].glABC, 1, this->PointLight::getCoeficients());
    glUniform4fv(gl_my_pointLights[index].glPos, 1, this->PointLight::getLightPosition());



    qDebug() << "PointLights toGPU3.....";
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
