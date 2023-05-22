#version 330
layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;
layout (location = 2) in vec4 vNormals;
layout (location = 3) in vec2 vTexCoord;

uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 globalAmbient;
uniform vec4 obs;

struct materials{
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
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

uniform lights l[5];
uniform materials m[1];

out vec4 color;
//out vec4 gouraud_color;
out vec4 position;
out vec2 texCoord;
out vec4 normals;
out float distanceOut; //pasamos como out para no calularla 2 veces

void main(){
    position = vPosition;
    normals = vNormals;
    texCoord = vTexCoord;

    gl_Position = projection*model_view*vPosition;
    gl_Position = gl_Position/gl_Position.w;

    // definimos el centro y el radio
    float stormRadius = 0.9;
    vec3 stormCenter = vec3(0.0, 0.0, 0.0);

    // calculamos la distancia
    //color = vec4(vec3(gl_FragCoord.z), 1.0);
    float distance = abs(gl_FragCoord.z - stormCenter.z);
    distanceOut = distance;

    if (distance >= stormRadius) {
        // dentro d la tormenta usamos el gouraud con tinte azul
        vec3 N = normalize(vec3(vNormals.x,vNormals.y,vNormals.z));
        vec3 L = normalize(position[0] - vec3(vPosition.x,vPosition.y,vPosition.z));
        vec3 V = normalize(vec3(obs.x,obs.y,obs.z));
        vec3 R = normalize(2.0f * dot(N,L) * N - L);
        vec3 I = m[0].Ka*l[0].Ia + m[0].Kd*l[0].Id*dot(L,N) + m[0].Ks*l[0].Is*pow(max(dot(V,R), 0), m[0].shininess);
        vec4 gouraud = vec4(globalAmbient+I,1.0);

        vec4 tintedColor = vec3(0.0, 0.0, 1.0,1.0); // tinte azul
        color = vec4(tintedColor*gouraud); //asi aplicamos tinte azul

    } else {
        // fuera de la tormenta usamos phong phong
        color = vColor;
    }

}
