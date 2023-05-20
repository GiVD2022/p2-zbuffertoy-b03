#version 330

layout (location = 0) in vec4 vPosition;
layout (location = 1) in vec4 vColor;
layout (location = 2) in vec3 vNormal;

uniform mat4 model_view;
uniform mat4 projection;
uniform vec3 glAmbientLight;
out vec4 position;
out vec4 normal;

void main(){
    gl_Position = projection * model_view * vPosition;
    gl_Position = gl_Position / gl_Position.w;
    position = vPosition;
    normal = vec4(vNormal, 1.0f);
}
