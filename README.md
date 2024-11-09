<div style="display: flex; align-items: center; height: 200;">
  <img src="https://biodiversidad.gt/portal/images/layout/UVG_logo.png" width="50%",  alt="Imagen 1"/>
</div>

# Evaluación e implementación de algoritmos genéticos para aplicaciones en robótica y otras áreas de Ingeniería Mecatrónica
###  Autor: Jose Pablo Petion Rivas

------------

## Introducción y Descripción del proyecto

Este proyecto consiste en el desarrollo de algoritmos genéticos para aplicaciones prácticas en las areas mencionadas. Se desarrollaron diferentes aplicaciones de dicho algoritmo, tales como: Optimización de funciones multivariable, Búsqueda de trayectorias libres de obstáculos en 2D para robots móviles al igual que en 3D para drones, y por último, busquéda de mejor filtro para segmentación de imágenes. Estos algoritmos han sido aplicados a simulaciones realistas en el entorno de Webots, demostrando el potencial que tienen en area incursionada.

![Imagen de Introducción](https://images.spiceworks.com/wp-content/uploads/2023/08/30104126/Genetic-Algorithm.jpg)

Los algoritmos genéticos son estructuras que modelan la evolución genética, donde las características de los individuos se expresan mediante genotipos. Estos algorítmos son aplicados a problemas de búsqueda y optimización, de manera que simulen el ciclo evolutivo con el paso de generaciones hasta obetener al mejor indiviuo como solución. 

------------
## Objetivos

- Evaluar la estructura general del algoritmo genético.
- Evaluar el algoritmo genético en problemas de busqueda de trayectorias 2D y 3D, al igual que para la segmentación de imagenes.
- Implementar los algoritmos en simulaciones realistas.

------------


## Desarrollo

El proyecto se baso en los siguientes puntos:

1. **Validación de estructura algorítmo genético**
En esta implementación se validó la estructura principal de un algorítmo genético. El codigo se basó en una implementación para optimizar funciones de costo y funciones de superficies tridimesionales. Para esta parte consultar el codigo de referencia en La [carpeta 1](./Codigo%20MATLAB/AG_Antecedentes) para optimización de funciones de costo y [carpeta 2](./Codigo%20MATLAB/SurfMaxMin_GA/) para maximizar funciones multi-variable.

2. **Implementación en búsqueda de trayectorias 2D**
Esta impletanción se trata de buscar la mejor trayectoria libre de obstáculos en un mapa 2D. Los obstáculos fueron creados como objetos cilíndricos en un mapa n x m, asumiendo una ruta desde el punto de inicio hasta el punto de final. Este algorítmo puede econtrarse en la [carpeta 4](./Codigo%20MATLAB/Pathplanning_GA).

3.  **Implementación en búsqueda de trayectorias 3D** 
El problema a optimizar en esta implementación es encontrar una trayectoria libre de obstáculos en un espacio tridimensional. Considerando los obstáculos en el terreno como paredes que forman un laberinto con planos 2D. Esta implementación se encuentra en la [carpeta 3](./Codigo%20MATLAB/Drone_MoveGA).

4. **Implementación en búsqueda de Filtros para segementación de imágenes**
Por último la implementación en procesamiento de imagenes consiste en la búsqueda de los mejores valores para filtrar una imágen. El filtro busca segementar la imágen de manera que aisle el objeto como una región binaria, aplicando la mejor solucion del AG, como límites del filtro en espacio HSV. Este considera una imágen de referencia que funciona para la mayoria de objetos esféricos. El código de esta implementación se encuentra en la [carpeta 5](./Codigo%20MATLAB/ImageSegmentation_GA).

![Imagen de Desarrollo](images/imagen_desarrollo.png)

## Conclusiones
- Los algoritmos demostraron ser eficientes e implementables en las areas establecidas. 
- Se valido la estructura general de los algoritmos genéticos. 
- Se desarrollaron las simulaciones realistas donde se aplican los algoritmos genéticos. 
![Imagen de Conclusiones](images/imagen_conclusiones.png)

