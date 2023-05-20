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

uniform DirLight myDirLights[4];

struct PointLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
};

uniform PointLight myPointLights[4];

struct SpotLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
    vec3 dir;
    float cosAngle;
};

uniform SpotLight mySpotLights[4];

struct Material{
    vec3 Ka;
    vec3 Kd;
    vec3 Ks;
    float shiness;
    float opacity;
};
uniform Material myMaterial;

out vec4 colorOut;
uniform int numl;
uniform vec4 AmbientGlobal;


const int numShades = 5;
const vec3 shades[numShades] = vec3[](
    vec3(0.0,0.0,0.0),
    vec3(0.2,0.2,0.2),
    vec3(0.4,0.4,0.4),
    vec3(0.6,0.6,0.6),
    vec3(0.8,0.8,0.8)
);

void main(){
    // Paso 1: Calculamos la normal del fragmento
    vec3 normal = normalize(vNormal);

    // Paso 2: Calculamos la intensidad de la luz para cada fuente de luz
    float intensity = 0.0;
    for (int i = 0; i < numl; i++) {
        // Calcular la intensidad difusa (Id)
        vec3 lightDir = normalize(-myPointLights[i].pos.xyz + vPosition.xyz);
        float lambertian = max(dot(normal, lightDir), 0.0);
        vec3 Id = myPointLights[i].Id * lambertian;

        // Calcular la intensidad specula (Is)
        vec3 viewDir = normalize(-vPosition.xyz);
        vec3 reflectDir = reflect(-lightDir, normal);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), myMaterial.shiness);
        vec3 Is = myPointLights[i].Is * spec;

        intensity += (Id + Is).x;
    }

    // Paso 3: Asignar un color según el valor de intensidad
    vec3 color = vec3(0.0, 0.0, 0.0);
    for (int i = 0; i < numShades; i++) {
        if (intensity > float(i)/float(numShades-1)) {
            color = shades[i];
        } else {
            break;
        }
    }

    // Paso 4: Normalizar el resultado
    colorOut = vec4(color, 1.0);
}
