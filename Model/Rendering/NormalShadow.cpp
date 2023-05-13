#include "NormalShadow.hh"


float NormalShadow::computeShadow(shared_ptr<Scene> scene, shared_ptr<Light> light, vec3 point){
    float result = 0.01f;
    HitInfo info = HitInfo();
    vec3 L = normalize(light->vectorL(point)); //creamos el vector del punto a la luz.
    Ray ray_hit = Ray(point + result * L, L); //creamos un rayo facha que empieza en el punto y va hacia la luz.
    if(scene->hit(ray_hit, 0.0001, float('inf'), info)){//comprobamos si el rayo intercepta algún objeto, y en caso de que sí lo haga entonces devuelve true y por tanto el valor es de 0.
        return 0.0f;
    }
    return 1.0f; //sino es de 1
}

vec3 NormalShadow::shading(shared_ptr<Scene> scene, HitInfo &info, vec3 lookFrom, vector<shared_ptr<Light>> lights, vec3 globalLight){
    vec3 shading = vec3(0);
    for(const shared_ptr<Light> &light: lights){
        float shadow = computeShadow(scene, light, info.p);
        vec3 normal = (info.normal + 1.0f)/2.0f;
        vec3 lightShading = normal * shadow;
        shading += lightShading;
    }

    return shading;
}

