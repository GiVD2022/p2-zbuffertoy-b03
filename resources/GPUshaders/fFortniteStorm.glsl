#version 330
uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 globalAmbient;
uniform vec4 obs;

in vec4 color;
in vec4 position;
in vec2 texCoord;
in vec4 normals;
in float distance; //ya la calculamos en el vertex

struct materials{
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
    //vec3 kt;
    float nut;
    float shininess;
    float opacity;
};

struct lights{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    float a; //atenuacion
    float b; //atenuacion
    float c; //atenuacion
    vec3 pos;
    vec3 direction;
    float anguloApertura;
    float spotExponent;
    int typeL;
};

uniform lights l[2];
uniform materials m[1];
out vec4 colorOut;


void main() {
    // definimos el centro  del radio
    float stormRadius = 0.9;
    vec3 stormCenter = vec3(0.0, 0.0, 0.0);

    if (distance >= stormRadius) {
        // dentro de la tormenta, usamos Gouraud-Phong shading tintado de azul
        colorOut = color;

    } else {
        // fuera de la tormenta, use Phong-Phong shading
        vec3 N = normalize(vec3(normals.x,normals.y,normals.z));
        vec3 L = normalize(position[0] - vec3(position.x,position.y,position.z));
        vec3 V = normalize(vec3(obs.x,obs.y,obs.z));
        vec3 R = normalize(2.0f * dot(N,L) * N - L);
        vec3 I = (m[0].Ka * l[0].Ia) + (m[0].Kd * l[0].Id * dot(L,N)) + (m[0].Ks * l[0].Is * pow(max(dot(V,R), 0), m[0].shininess));
        colorOut = vec4(globalAmbient+I,1.0);

    }
}
