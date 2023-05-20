#version 330

layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;
layout (location = 2) in vec3 vNormal;

uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 glAmbientLight;

struct DirLight {
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 dir;
};

uniform DirLight myDirLights[4];

struct PointLight {
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
};

uniform PointLight myPointLights[4];

struct SpotLight {
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
    vec3 dir;
    float cosAngle;
};

uniform SpotLight mySpotLights[4];

struct Material {
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
    float shiness;
    float opacity;
};

uniform Material myMaterial;

out vec4 fragColor;

void main() {
    vec4 N = normalize(vNormal);
    vec4 V = normalize(vec4(-vPosition.xyz, 0.0));

    vec4 ambient = vec4(glAmbientLight * myMaterial.Ka, 1.0);
    vec4 diffuse = vec4(0.0);
    vec4 specular = vec4(0.0);

    for (int i = 0; i < 4; i++) {
        // Direccional
        if (myDirLights[i].dir != vec3(0.0)) {
            vec4 L = normalize(vec4(-myDirLights[i].dir, 0.0));
            vec4 H = normalize(L + V);
            diffuse += myDirLights[i].Id * vec4(myMaterial.Kd * max(dot(L, N), 0.0), 1.0);
            specular += myDirLights[i].Is * vec4(myMaterial.Ks * pow(max(dot(H, N), 0.0), myMaterial.shiness), 1.0);
        }

        // Puntual
        if (myPointLights[i].pos.w != 0.0) {
            vec4 L = normalize(myPointLights[i].pos - vPosition);
            vec4 H = normalize(L + V);
            float dist = length(myPointLights[i].pos - vPosition);
            float attenuation = 1.0 / (myPointLights[i].abc.x * dist * dist + myPointLights[i].abc.y * dist + myPointLights[i].abc.z);
            diffuse += myPointLights[i].Id * vec4(myMaterial.Kd * max(dot(L, N), 0.0), 1.0) * attenuation;
            specular += myPointLights[i].Is * vec4(myMaterial.Ks * pow(max(dot(H, N), 0.0), myMaterial.shiness), 1.0) * attenuation;
        }

        // Spot
        if (mySpotLights[i].pos.w != 0.0) {
            vec4 L = normalize(mySpotLights[i].pos - vPosition);
            vec4 H = normalize(L + V);
            float dist = length(mySpotLights[i].pos - vPosition);
            float attenuation = 1.0 / (mySpotLights[i].abc.x * dist * dist + mySpotLights[i].abc.y * dist + mySpotLights[i].abc.z);
            float angle = dot(-L, normalize(vec4(mySpotLights[i].dir, 0.0)));
            if (angle > mySpotLights[i].cosAngle) {
                float spotEffect = pow(angle, mySpotLights[i].pos);
                diffuse += mySpotLights[i].Id * vec4(myMaterial.Kd * max(dot(L, N), 0.0), 1.0) * spotEffect * attenuation;
                specular += mySpotLights[i].Is * vec4(myMaterial.Ks * pow(max(dot(H, N), 0.0), myMaterial.shiness), 1.0) * spotEffect * attenuation;
            }
        }
    }

    fragColor = ambient + diffuse + specular;
    fragColor.a = myMaterial.opacity;
}
