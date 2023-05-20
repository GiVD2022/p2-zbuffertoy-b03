#version 330

layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;
layout (location = 2) in vec3 vNormal;

uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 glAmbientLight;


struct DirLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 dir;
};

uniform DirLight myDirLights[];

struct PointLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 pos;
};

uniform PointLight myPointLights[];

struct SpotLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 pos;
    vec3 dir;
    float cosAngle;
};

uniform SpotLight mySpotLights[];

struct Material{
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
    float shiness;
    float opacity;
};

uniform Material myMaterial;

out vec4 colorOut;

void main() {
    // TO DO ns hacer este :c
}
