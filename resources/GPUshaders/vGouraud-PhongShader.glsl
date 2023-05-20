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

out vec4 fragmentColor;

vec3 phongModel(vec3 norm, vec4 color)
{
    vec3 difossa = vec3(0.0, 0.0, 0.0);
    vec3 ambiental = vec3(0.0, 0.0, 0.0);
    vec3 especular = vec3(0.0, 0.0, 0.0);

    // Afegim totes les lights del tipus direcional N6
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(-myDirLights[i].dir);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);

        // Ka (component ambiental)
        ambiental += myDirLights[i].Ia * myMaterial.Ka;

        // Kd (component difossa)
        float diffuseFactor = max(dot(N, L), 0.0);
        difossa += diffuseFactor * myDirLights[i].Id * myMaterial.Kd;

        // Ks (component especular)
        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        especular += myDirLights[i].Is * myMaterial.Ks * specularFactor;
    }

    // Afegim les Point lights
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(myPointLights[i].pos.xyz - vPosition.xyz);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);

        // distancia amb atenuació
        float distance = length(myPointLights[i].pos.xyz - vPosition.xyz);
        float attenuation = 1.0 / (myPointLights[i].abc.x + myPointLights[i].abc.y * distance + myPointLights[i].abc.z * distance * distance);

        // Component ambiental
        ambiental += myPointLights[i].Ia * myMaterial.Ka * attenuation;

        // Component difossa
        float diffuseFactor = max(dot(N, L), 0.0);
        difossa += diffuseFactor * myPointLights[i].Id * myMaterial.Kd * attenuation;

        // Component especular
        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        especular += myPointLights[i].Is * myMaterial.Ks * specularFactor * attenuation;
    }

    // Spot Lights de la meva escena
    for (int i = 0; i < 4; i++)
    {
        vec3 L = normalize(mySpotLights[i].pos.xyz - vPosition.xyz);
        vec3 N = normalize(norm);
        vec3 V = normalize(-vPosition.xyz);
        vec3 R = reflect(L, N);

        // Distancia
        float distance = length(mySpotLights[i].pos.xyz - vPosition.xyz);
        float attenuation = 1.0 / (mySpotLights[i].abc.x + myPointLights[i].abc.y * distance + myPointLights[i].abc.z * distance * distance);

        // StackOverflow xd
        float coneFactor = dot(L, normalize(-mySpotLights[i].dir));
        if (coneFactor < mySpotLights[i].cosAngle)
            coneFactor = 0.0;
        else
            coneFactor = pow(coneFactor, myMaterial.shiness);

        // Component ambient
        ambiental += mySpotLights[i].Ia * myMaterial.Ka * attenuation;

        // Component difos
        float diffuseFactor = max(dot(N, L), 0.0);
        difossa += diffuseFactor * mySpotLights[i].Id * myMaterial.Kd * attenuation * coneFactor;

        // component especular
        float specularFactor = pow(max(dot(R, V), 0.0), myMaterial.shiness);
        especular += mySpotLights[i].Is * myMaterial.Ks * specularFactor * attenuation * coneFactor;
    }

    vec3 phongColor = ambiental + difossa + especular;
    return phongColor * color.rgb;
}

void main()
{
    vec4 worldPosition = model_view * vPosition;
    vec3 normal = normalize(transpose(inverse(mat3(model_view))) * vColor.xyz);
    fragmentColor = vec4(phongModel(normal, vColor), myMaterial.opacity);
    gl_Position = projection * worldPosition;
}
