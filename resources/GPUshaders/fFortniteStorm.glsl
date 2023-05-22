#version 330

struct Material {
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

in vec4 color;
in vec4 position;
in vec3 normal;

uniform vec3 glAmbientLight;
uniform SpotLight mySpotLights[4];
uniform mat4 model_view;
uniform vec4 obs;
out vec4 colorOut;

void main()
{/*
    vec4 colorPhong;
    vec4 transformedNormal = model_view * vec4(normal, 0.0);
    vec4 normal = normalize(transformedNormal);

    vec3 ambient = vec3(0.0);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);

    vec4 L, N, V, H;
    float attenuation, dist;
    N = normalize(normal);

    for (int i = 0; i < 4; i++) {
        V = normalize(obs - position);
        if(myDirLights[i].dir != vec3(0)){
            ambient += myDirLights[i].Ia * myMaterial.Ka;
            L = vec4(normalize(-myDirLights[i].dir), 1.0f);
            diffuse += myDirLights[i].Id * myMaterial.Kd * max(dot(L, N), 0.0f);
            H = normalize(L+V);
            specular += myDirLights[i].Is * myMaterial.Ks * pow(max(dot(H, N),0.0f), myMaterial.shiness);
        }else if(mySpotLights[i].dir != vec3(0)){
            ambient += mySpotLights[i].Ia * myMaterial.Ka;
            L = vec4(normalize(-mySpotLights[i].dir), 1.0f);
            diffuse += mySpotLights[i].Id * myMaterial.Kd * max(dot(L, N), 0.0f);
            H = normalize(L+V);
            specular += mySpotLights[i].Is * myMaterial.Ks * pow(max(dot(H, N),0.0f), myMaterial.shiness);
        }else{
            ambient += myPointLights[i].Ia * myMaterial.Ka;
            L = normalize(myPointLights[i].pos - position);
            diffuse += myPointLights[i].Id * myMaterial.Kd * max(dot(L,N), 0.0f);
            H = normalize(L+V);
            specular += myPointLights[i].Is * myMaterial.Ks * pow(max(dot(H, N),0.0f), myMaterial.shiness);
        }
    }

    //fragmentColor = glAmbientLight * myMaterial.Ka
    //fragmentColor = ambient;
    //fragmentColor = diffuse;
    //fragmentColor = specular;
    colorPhong =  vec4(((glAmbientLight * myMaterial.Ka) + ambient + diffuse + specular), 1.0f);


    if(position.x * position.x + position.y * position.y + position.z * position.z < 1){
        vec4 tintePitufo = (0,0,1,1);
        //colorOut = color * tintePitufo;
        colorOut = vec4(1);
    } else{
        //colorOut = colorPhong;
        colorOut = vec4(1);
    }
    */
    colorOut= vec4(1);
}
