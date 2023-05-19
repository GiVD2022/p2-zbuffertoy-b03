#version 330

layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;

uniform mat4 model_view;
uniform mat4 projection;

//Fase 1: Creem el vec3 de floats perque pugui aceptar-ho (N6)
uniform vec3 glAmbientLight;

// Creació de les diferents llums, en el fitxer glsl tal com va fer per vShader (N6) -> Usats per GpuLight (ho fem struct perque ho demanen així)
//N6
struct Light{
    vec3 Ia; //Intensitat ambiental
    vec3 Id; // Intensitat difusa
    vec3 Is; // Intensitat especular
    vec4 pos; // Posició (en el cas de llum puntual)
    vec3 dir; // Direcció (en el cas de llum direccional o llum tipo spot)
    // Coeficients d'atenuació
    vec3 abc;
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

out vec4 color;

void main()
{
    gl_Position = projection*model_view*vPosition;
    gl_Position = gl_Position/gl_Position.w;

    color = vColor;
}
