#ifndef POINTLIGHT_H
#define POINTLIGHT_H

#include "Light.hh"


class PointLight: public Light {
public:
    PointLight();
    /*
     * Constructor de la classe PointLight.
     * param posicio: posició de la llum.
     * param Ia: component ambient de la llum.
     * param Id: component difosa de la llum.
     * param Is: component especular de la llum.
     * param a: coeficient a de l'atenuacio.
     * param b: coeficient b de l'atenuacio.
     * param c: coeficient c de l'atenuacio.
     * */
    PointLight(vec3 Ia, vec3 Id, vec3 Is, vec3 abc, vec4 posicio);
    virtual ~PointLight() {}
    vec3 getPos();
    vec3 getCoeficients();
    //Afegeixo getters del terme constant, lineal i quadratic (N6)
    float getA();
    float getB();
    float getC();

    virtual vec3 vectorL(vec3 point) override;
    virtual float attenuation(vec3 point) override;
    virtual float distanceToLight(vec3 point) override;

    virtual void read (const QJsonObject &json) override;
    virtual void write(QJsonObject &json) const override;
    virtual void print(int indentation) const override;
protected:

    vec3 pos;
    float a; // atenuacio: terme constant
    float b; // atenuacio: terme lineal
    float c; // atenuacio: terme quadratic

};

#endif // POINTLIGHT_H
