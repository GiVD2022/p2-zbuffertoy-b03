#version 330

layout (location = 0) in vec4 vPosition; // Posició dels vèrtexs
layout (location = 1) in vec4 vColor; // Color dels vèrtexs
layout (location = 2) in vec3 vNormal; // Normal dels vèrtexs

uniform mat4 model_view; // Matriu de modelat i visualització
uniform mat4 projection; // Matriu de projecció
uniform vec3 glAmbientLight; // Color de la llum ambiental global

struct DirLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 dir;
};

uniform DirLight myDirLights[4]; // Array de llums puntuals

struct PointLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
};

uniform PointLight myPointLights[4]; // Array de llums puntuals

struct SpotLight{
    vec3 Ia;
    vec3 Id;
    vec3 Is;
    vec3 abc;
    vec4 pos;
    vec3 dir;
    float cosAngle;
};

uniform SpotLight mySpotLights[4]; // Array de llums de faret

struct Material{
    vec3 Ka; // Coeficient d'ambient
    vec3 Kd; // Coeficient de difusió
    vec3 Ks; // Coeficient especular
    float shiness; // Brillositat del material
    float opacity; // Opacitat del material
};

uniform Material myMaterial; // Material dels objectes representats

out vec4 fragmentColor; // Color final dels píxels

vec3 phongModel(vec3 norm, vec4 color)
{
    // Llum ambiental
    vec3 diffuse = vec3(0.0, 0.0, 0.0);
    vec3 ambient = vec3(0.0, 0.0, 0.0);
    vec3 specular = vec3(0.0, 0.0, 0.0);

    // Llums directes
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(-myDirLights[i].dir);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);

        ambient += myDirLights[i].Ia * myMaterial.Ka;

        float diffuseFactor = max(dot(N, L), 0.0);
        diffuse += diffuseFactor * myDirLights[i].Id * myMaterial.Kd;

        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        specular += myDirLights[i].Is * myMaterial.Ks * specularFactor;
    }

    // Llums puntuals
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(myPointLights[i].pos.xyz - vPosition.xyz);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);
        float distance = length(myPointLights[i].pos.xyz - vPosition.xyz);
        float attenuation = 1.0 / (myPointLights[i].abc.x + myPointLights[i].abc.y * distance + myPointLights[i].abc.z * distance * distance);
        ambient += myPointLights[i].Ia * myMaterial.Ka * attenuation;
        float diffuseFactor = max(dot(N, L), 0.0);
        diffuse += diffuseFactor * myPointLights[i].Id * myMaterial.Kd * attenuation;
        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        specular += myPointLights[i].Is * myMaterial.Ks * specularFactor * attenuation;
    }

    // Llums de faret
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(mySpotLights[i].pos.xyz - vPosition.xyz);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);
        float distance = length(mySpotLights[i].pos.xyz - vPosition.xyz);
        float attenuation = 1.0 / (mySpotLights[i].abc.x + myPointLights[i].abc.y * distance + myPointLights[i].abc.z * distance * distance);
        float coneFactor = dot(L, normalize(-mySpotLights[i].dir));
        if (coneFactor < mySpotLights[i].cosAngle)
            coneFactor = 0.0;
        else
            coneFactor = pow(coneFactor, myMaterial.shiness);
        ambient += mySpotLights[i].Ia * myMaterial.Ka * attenuation;
        float diffuseFactor = max(dot(N, L), 0.0);
        diffuse += diffuseFactor * mySpotLights[i].Id * myMaterial.Kd * attenuation * coneFactor;
        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        specular += mySpotLights[i].Is * myMaterial.Ks * specularFactor * attenuation * coneFactor;
    }

    vec3 phongColor = ambient + diffuse + specular;
    return phongColor * color.rgb;
}

void main()
{
    // Transformem la posició dels vèrtexs per obtenir la seva posició en el món
    vec4 worldPosition = model_view * vPosition;
    // Calcula la normalització de la normal dels vèrtexs
    vec3 normal = normalize(transpose(inverse(mat3(model_view))) * vColor.xyz);
    // Càlcul del color final del píxel a través del model Phong
    fragmentColor = vec4(phongModel(normal, vColor), myMaterial.opacity);
    // Projectem la posició dels vèrtexs a la pantalla
    gl_Position = projection * worldPosition;
}
