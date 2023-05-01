# ZBufferToy
Codi de la Pràctica 2 de GiVD: ZBufferToy 2022-23

## Taula de continguts

* [Equip](#Equip)
* [Abstract](#Abstract)
* [Features](#Features)
* [Extensions addicionals](#Extensions)
* [Memòria](#Memòria)


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
        - [x] Ambient Global [Nil] + [Zijian]
        - [x] Puntual [Nil] 
        - [x] Direccional [Nil] 
        - [x] Spotlight [Nil] 
        - [x] Conexió GPU  + vshader1.glsl implementation [Nil]
        - [ ] Testeig [Nil] -> Almost there
    - Materials: 
       - [ ] Pas a la GPU
       - [ ] Lectura de fitxers .json
    - Shading
        - [ ] Color
        - [ ] Normal
        - [ ] Depth 
        - [ ] Phong-Gouraud 
        - [ ] Phong-Phong
        - [ ] BlinnPhong-Gouraud 
        - [ ] BlinnPhong-Phong
        - [ ] Cel-shading
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
        
