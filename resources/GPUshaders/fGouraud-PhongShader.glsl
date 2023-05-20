#version 330

#define Puntual 0
#define Directional 1

in vec4 position;
in vec4 normal;

uniform vec4 obs;
uniform int lengthLights;
out vec4 colorOut;


struct Material{
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
    float shiness;
    float opacity;
};

uniform Material myMaterial;

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

uniform vec3 globalLight;

void main()
{
    vec3 ambient = vec3(0.0f);
    vec3 diffuse = vec3(0.0f);
    vec3 specular = vec3(0.0f);

    vec4 L, N, V, H;
    float attenuation, dist;
    N = normalize(normal);

    for (int i = 0; i < lengthLights; i++) {
        if (myDirLights[i]) {
            L = normalize(-myDirLights[i].dir);
        } else {
            L = normalize(myPointLights[i].pos - position);
        }

        if (myPointLights[i].abc.x <= 0.001f && myPointLights[i].abc.y <= 0.001f && myPointLights[i].abc.z <= 0.001f) {
            attenuation = 1.0f;
        } else {
            dist = distance(position.xyz, myPointLights[i].pos.xyz);
            attenuation = 1.0f / ((myPointLights[i].abc.x * (dist * dist)) + (myPointLights[i].abc.y * dist) + myPointLights[i].abc.z);
        }

        ambient += myPointLights[i].Ia * myMaterial.Ka;
        diffuse += (myMaterial.Kd * myPointLights[i].Id * max(dot(L, N), 0.0f)) * attenuation;

        V = normalize(obs - position);
        H = normalize(L + V);
        specular += (myMaterial.Ks * myPointLights[i].Is * pow(max(dot(H, N), 0.0f), myMaterial.shiness)) * attenuation;
    }

    colorOut = vec4(((globalLight * myMaterial.Ka) + ambient + diffuse + specular), 1.0f);
}
