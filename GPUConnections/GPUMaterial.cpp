#include "GPUConnections/GPUMaterial.hh"


GPUMaterial::GPUMaterial(vec3 Ka, vec3 Kd, vec3 Ks, float shiness, float opacity): Material(Ka, Kd, Ks, shiness, opacity){
}

GPUMaterial::GPUMaterial() {
}

void GPUMaterial::toGPU(shared_ptr<QGLShaderProgram> p) {
    // TO DO Pràctica 2: Fase 1: enviar les propietats de Ia, Id i Is a la GPU

    //N6
    // Obtenir ubis de les variables del Shader
    gl_my_materials[0].glKa = program->uniformLocation(QString("myMaterials[%0].Ia").arg(0));
    gl_my_materials[1].glKd = program->uniformLocation(QString("myMaterials[%1].Id").arg(1));
    gl_my_materials[2].glKs = program->uniformLocation(QString("myMaterials[%2].Is").arg(2));
    gl_my_materials[3].glShiness = program->uniformLocation(QString("myMaterials[%3].pos").arg(3));
    gl_my_materials[4].glOpacity = program->uniformLocation(QString("myMaterials[%4].dir").arg(4));

    vec3 vectorKa(0.1f, 0.1f, 0.1f);
    vec3 vectorKd(1.0f, 1.0f, 1.0f);
    vec3 vectorKs(0.8f, 0.8f, 0.8f);

    float shiness = 3.3f; // només es una posició per la llum puntual
    float opacity = 2.0f;


    // Enviar valors a GPU
    glUniform3fv(gl_my_materials[0].glKa, 1, vectorKa);
    glUniform3fv(gl_my_materials[1].glKd, 1, vectorKd);
    glUniform3fv(gl_my_materials[2].glKs, 1, vectorKs);
    glUniform1f(gl_my_materials[3].glShiness, shiness);
    glUniform1f(gl_my_materials[4].glOpacity, opacity);
}

vec3 GPUMaterial::getDiffuse(vec2 point) const {
    return Kd;
}

void GPUMaterial::read (const QJsonObject &json)
{
    if (json.contains("ka") && json["ka"].isArray()) {
        QJsonArray auxVec = json["ka"].toArray();
        Ka[0] = auxVec[0].toDouble();
        Ka[1] = auxVec[1].toDouble();
        Ka[2] = auxVec[2].toDouble();
    }
    if (json.contains("kd") && json["kd"].isArray()) {
        QJsonArray auxVec = json["kd"].toArray();
        Kd[0] = auxVec[0].toDouble();
        Kd[1] = auxVec[1].toDouble();
        Kd[2] = auxVec[2].toDouble();
    }
    if (json.contains("ks") && json["ks"].isArray()) {
        QJsonArray auxVec = json["ks"].toArray();
        Ks[0] = auxVec[0].toDouble();
        Ks[1] = auxVec[1].toDouble();
        Ks[2] = auxVec[2].toDouble();
    }
    if (json.contains("shininess") && json["shininess"].isDouble())
        shininess = json["shininess"].toDouble();
    if (json.contains("opacity") && json["opacity"].isDouble())
        opacity = json["opacity"].toDouble();

}


//! [1]
void GPUMaterial::write(QJsonObject &json) const
{
    QJsonArray auxArray;
    auxArray.append(Ka[0]);auxArray.append(Ka[1]);auxArray.append(Ka[2]);
    json["ka"] = auxArray;

    QJsonArray auxArray2;
    auxArray2.append(Kd[0]);auxArray2.append(Kd[1]);auxArray2.append(Kd[2]);
    json["kd"] = auxArray2;

    QJsonArray auxArray3;
    auxArray3.append(Ks[0]);auxArray3.append(Ks[1]);auxArray3.append(Ks[2]);
    json["ks"] = auxArray3;
    json["opacity"] = opacity;
    json["shininess"] = shininess;
}

//! [1]

void GPUMaterial::print(int indentation) const
{
    const QString indent(indentation * 2, ' ');

    QTextStream(stdout) << indent << "Ka:\t" << Ka[0] << ", "<< Ka[1] << ", "<< Ka[2] << "\n";
    QTextStream(stdout) << indent << "Kd:\t" << Kd[0] << ", "<< Kd[1] << ", "<< Kd[2] << "\n";
    QTextStream(stdout) << indent << "Ks:\t" << Ks[0] << ", "<< Ks[1] << ", "<< Ks[2] << "\n";
    QTextStream(stdout) << indent << "shininess:\t" << shininess<< "\n";
    QTextStream(stdout) << indent << "opacity:\t" << opacity<< "\n";
}

void GPUMaterial::draw(){
    //To do
}
