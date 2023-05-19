#include "GPUSpotLight.hh"

GPUSpotLight::GPUSpotLight(vec3 Ia, vec3 Id, vec3 Is, vec3 abc, vec4 pos, vec3 dir, float angle) :
    SpotLight(Ia, Id, Is, abc, pos, dir, angle)
{

}

void GPUSpotLight::toGPU(shared_ptr<QGLShaderProgram> p) {
    qDebug() << "SpotLights toGPU.....";
    program = p;
    int index;

    //Hola! Això em permet agafar el termet i-essim, agafo getter i setter de la classe Light!
    index = SpotLight::getIndex();

    // Obtenir ubis de les variables del Shader
    gl_my_spotLights[index].glIa = program->uniformLocation("mySpotLights.Ia");
    gl_my_spotLights[index].glId = program->uniformLocation("mySpotLights.Id");
    gl_my_spotLights[index].glIs = program->uniformLocation("mySpotLights.Is");
    gl_my_spotLights[index].glABC = program->uniformLocation("mySpotLights.abc");
    gl_my_spotLights[index].glPos = program->uniformLocation("mySpotLights.pos");
    gl_my_spotLights[index].glDir = program->uniformLocation("mySpotLights.dir");
    gl_my_spotLights[index].glCosAngle = program->uniformLocation("mySpotLights.cosAngle");


    qDebug() << "SpotLights toGPU2.....";

    // Enviar valors a GPU
    glUniform3fv(gl_my_spotLights[index].glIa, 1, this->SpotLight::getIa());
    glUniform3fv(gl_my_spotLights[index].glId, 1, this->SpotLight::getId());
    glUniform3fv(gl_my_spotLights[index].glIs, 1, this->SpotLight::getIs());
    glUniform3fv(gl_my_spotLights[index].glABC, 1, this->SpotLight::getCoeficients());
    glUniform4fv(gl_my_spotLights[index].glPos, 1, this->SpotLight::getLightPosition());
    glUniform3fv(gl_my_spotLights[index].glDir, 1, this->SpotLight::getDirLight());
    glUniform1f(gl_my_spotLights[index].glCosAngle, this->SpotLight::getCosAngle());

    qDebug() << "SpotLights toGPU3.....";
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
