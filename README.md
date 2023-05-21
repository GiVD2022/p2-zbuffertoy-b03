# ZBufferToy
Codi de la Pràctica 2 de GiVD: ZBufferToy 2022-23

## Taula de continguts

* [Equip](#Equip)
* [Abstract](#Abstract)
* [Features](#Features)
* [Extensions addicionals](#Extensions)
* [Memòria](#Memòria)
* [Fotografies](#Fotografies)


## Equip

**B03**
* Arturo Latorre
* Zijian Jiang
* Nil Torrelles
* Asier Augusto
    
## Abstract

Petit resum de fins on heu arribat a fer

## Features

A continuació s'indica quines parts s'han fet i qui les ha implementat
- Fase 1
    - Lights
        - [x] Ambient Global [Nil] + [Zijian] + [Asier]
        - [x] Puntual [Nil] 
        - [x] Direccional [Nil] 
        - [x] Spotlight [Nil] 
        - [x] Conexió GPU  + vshader1.glsl implementation [Nil]
        - [x] Arreglament de Lights [Asier]
    - Materials: 
       - [x] Pas a la GPU [Arturo + Nil]
       - [x] Lectura de fitxers .json: [Arturo]
    - Shading
        - [x] Color: [Arturo]
            - [x] Conexió GPU: [Arturo]
        - [x] Normal: [Arturo]
            - [x] Conexió GPU: [Arturo]
        - [x] Depth: [Arturo]
            - [x] Conexió GPU: [Arturo]
        - [] Phong-Gouraud :  [Nil]
            - [x] Conexió GPU: [Nil]
        - [] Phong-Phong:  [Nil]
            - [x] Conexió GPU: [Nil]
        - [] BlinnPhong-Gouraud :
            - [x] Conexió GPU: [Nil]
        - [] BlinnPhong-Phong :  [Nil]
            - [x] Conexió GPU: [Nil]
        - [x] Cel-shading :  [Nil]
            - [x] Conexió GPU: [Nil]
    - Textures
        - [ ] Textura com material en un objecte 
        - [ ] Textura al pla base 
    - Adaptació a la lectura de fitxers de dades
        - [ ] Escenes virtuals 
        - [ ] SetUp
        - [ ] Escenes de dades 

- Fase 2 
    - [ ] Visió nocturna 
    - [ ] La Tempesta de Fornite
    - [ ] Èmfasi de siluetes 
    - [ ] Mapping indirecte de textures
    - [ ] Animacions amb dades temporals
    - [ ] Normal mapping 
    - [ ] Entorn amb textures
    - [ ] Reflexions
    - [ ] Transparències via objectes: 
    - [ ] Transparències via environmental mapping


## Extensions


## Memòria

- Fase 1
    Decideix el moment en el que cal passar la llum ambient global a la GPU (al initializeGL? Al updateGL? En
    crear un objecte? ). 
    -> Pasarem la llum ambient global, al initialieGL (metode de la classe GlWidget), es a dir, al inicialitzar l'aplicació. Ja que volem que la llum ambient global, 
        sigui estàtica, i no es modifiqui durant el trancurs de l'execució.
    
    Ara es crea una llum puntual al initializeGL() de la classe GLWidget, quan l’hauries de passar a la GPU? A l’inici de
    tot? Cada vegada que es visualitza l’escena? 
        
## Fotografies
- [ColorShading](https://github.com/GiVD2022/p2-zbuffertoy-b03/assets/72517965/2f0a62e8-087d-48ea-9e4d-98f665fa4cbf)
- [NormalShading](https://github.com/GiVD2022/p2-zbuffertoy-b03/assets/72517965/d112f997-9bc7-4e5d-82c1-85c3035a6dd9)
- [DepthShading](https://github.com/GiVD2022/p2-zbuffertoy-b03/assets/72517965/b2f31da9-8c0b-4edc-974d-f6d6b7b67685)

