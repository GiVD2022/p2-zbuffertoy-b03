#version 330

layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;
layout (location = 2) in vec3 vNormal;

uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 glAmbientLight;

// Creació de les diferents llums, en el fitxer glsl tal com va fer per vShader (N6) -> Usats per GpuLight (ho fem struct perque ho demanen així)
//N6
struct Light{
    vec3 Ia; //Intensitat ambiental
    vec3 Id; // Intensitat difusa
    vec3 Is; // Intensitat especular
    vec3 pos; // Posició (en el cas de llum puntual)
    vec3 dir; // Direcció (en el cas de llum direccional o llum tipo spot)
    // Coeficients d'atenuació
    float a;
    float b;
    float c;
    float cosAngle; // Coseno del ángulo de apertura, en el caso de luz tipo spot
};

uniform Light myLights[4]; // 4 represneta el nombre de llums que volem, es arbitraria
struct Material{
    vec3 Ka; //Intensitat ambiental
    vec3 Kd; // Intensitat difusa
    vec3 Ks; // Intensitat especular
    float shiness; // Posició (en el cas de llum puntual)
    float opacity; // Direcció (en el cas de llum direccional o llum tipo spot)

};

uniform Material myMaterial;
out vec4 fragmentColor;

void main(void)
{
    Material m1;


    // Calculate the interpolated normal
    vec3 normal = normalize(vNormal);

    // Calculate the interpolated color
    vec4 color = vColor;

    // Calculate the interpolated position
    vec4 position = vPosition;

    // Calculate the final color based on the lights
    vec3 finalColor = vec3(0.0);

    for (int i = 0; i < 4; i++) {
        vec3 lightDir;
        float attenuation = 1.0;

        if (myLights[i].pos != vec3(0.0)) {
            // Calculate the direction from the vertex to the light position
            lightDir = normalize(myLights[i].pos - position.xyz);

            // Calculate the distance from the vertex to the light position
            float distance = length(myLights[i].pos - position.xyz);

            // Calculate the attenuation factor
            attenuation = 1.0 / (myLights[i].a + myLights[i].b * distance + myLights[i].c * distance * distance);
        } else {
            // Use the light direction if it's a directional light or spot light
            lightDir = normalize(myLights[i].dir);
        }

        // Calculate the diffuse term
        float diffuse = max(dot(normal, lightDir), 0.0);

        // Calculate the specular term
        vec3 viewDir = normalize(-position.xyz);
        vec3 reflectDir = reflect(-lightDir, normal);
        float specular = pow(max(dot(viewDir, reflectDir), 0.0), myMaterial.shiness);

        // Calculate the final color contribution from this light
        vec3 lightColor = myLights[i].Ia * myMaterial.Ka +
                          myLights[i].Id * myMaterial.Kd * diffuse +
                          myLights[i].Is * myMaterial.Ks * specular;

        finalColor += lightColor * attenuation;
    }

    // Set the final color as the output
    fragmentColor = vec4(finalColor, 1.0);

    // Output the transformed vertex position
    gl_Position = position;
}
