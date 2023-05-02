#include "GPUConnections/GPULight.hh"


GPULight::GPULight(vec3 Ia, vec3 Id, vec3 Is): Light(Ia, Id, Is){
}

GPULight::GPULight() {
}

void GPULight::toGPU(shared_ptr<QGLShaderProgram> p) {
    // TO DO Pràctica 2: Fase 1: enviar les propietats de Ia, Id i Is a la GPU

    //N6
    // Obtenir ubis de les variables del Shader
    gl_my_lights[0].glIa = program->uniformLocation(QString("myLights[%0].Ia").arg(0));
    gl_my_lights[1].glId = program->uniformLocation(QString("myLights[%1].Id").arg(1));
    gl_my_lights[2].glIs = program->uniformLocation(QString("myLights[%2].Is").arg(2));
    gl_my_lights[3].glPos = program->uniformLocation(QString("myLights[%3].pos").arg(3));
    gl_my_lights[4].glDir = program->uniformLocation(QString("myLights[%4].dir").arg(4));
    gl_my_lights[5].glA = program->uniformLocation(QString("myLights[%5].a").arg(5));
    gl_my_lights[6].glB = program->uniformLocation(QString("myLights[%6].b").arg(6));
    gl_my_lights[7].glC = program->uniformLocation(QString("myLights[%7].c").arg(7));
    gl_my_lights[8].glCosAngle = program->uniformLocation(QString("myLights[%8].cosAngle").arg(8));

    vec3 vectorIa(0.1f, 0.1f, 0.1f);
    vec3 vectorId(1.0f, 1.0f, 1.0f);
    vec3 vectorIs(0.8f, 0.8f, 0.8f);

    vec3 vectorPos(10, 5, 0); // només es una posició per la llum puntual
    vec3 vectorDireccio(-0.5f, -0.2f, -0.8f);

    //coeficients atenuació
    float a = 0.2f; //coeficient lineal
    float b = 0.3f; // coeficient cuadratic
    float c = 0.5f; //coeficient constant

    //Coseno apertura
    const GLfloat angle_radians = 1.0472f; // 60 graus
    const GLfloat cos_angulo_apertura = cos(angle_radians / 2.0f);

    float cosAngle = cos_angulo_apertura;

    // Enviar valors a GPU
    glUniform3fv(gl_my_lights[0].glIa, 1, vectorIa);
    glUniform3fv(gl_my_lights[1].glId, 1, vectorId);
    glUniform3fv(gl_my_lights[2].glIs, 1, vectorIs);

    glUniform3fv(gl_my_lights[3].glPos, 1, vectorPos);
    glUniform3fv(gl_my_lights[4].glDir, 1, vectorDireccio);

    glUniform1f(gl_my_lights[5].glA, a);
    glUniform1f(gl_my_lights[6].glB, b);
    glUniform1f(gl_my_lights[7].glC, c);

    glUniform1f(gl_my_lights[8].glCosAngle, cosAngle);

}
