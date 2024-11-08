%% Universidad del Valle de Guatemala
% Trabajo de Graduación
% Autor: José Pablo Petion Rivas
% Año: 2024
% Descripción:
% Implementación de algoritmo genético para segementación de imagenes. Este
% AG se encarga de buscar los mejores límites para filtrado, en espació de
% color HSV, como solución del problema a optimizar. Este archivo puede
% implentarse en simulaciones con Webots para visión por computadora.
%% Inicialización para AG
% Configuración de la imagen
img = imread('ball.png');         % Carga la imagen de prueba 1
% img = imread('bowlingball.jpg');  % Carga la imagen de prueba 2
load referencia.mat                 
% load referencia1.mat              % Carga al imagen de referencia 1
% load referencia2.mat
maskReferencia = BW;
[height, width, ~] = size(img);

if height ~= size(maskReferencia, 1) && width ~= size(maskReferencia, 2)
    maskReferencia = imresize(maskReferencia, [height, width]);
end
% Convertir la imagen al espacio de color HSV
imgHSV = rgb2hsv(img);
% Configuración del AG
numGeneraciones = 30;       % Número máximo de generaciones
tamanoPoblacion = 50;       % Tamaño de la población
probMutacion = 0.1;         % Probabilidad de mutación

% Rango de límites de color (en espacio HSV)
limitesMin = [0, 0, 0, 0, 0, 0];   % Valores mínimos para H_min, H_max, S_min, S_max, V_min, V_max
limitesMax = [1, 1, 1, 1, 1, 1];   % Valores máximos para H_min, H_max, S_min, S_max, V_min, V_max

tic;
% Inicialización de la población
poblacion = inicializarPoblacion(tamanoPoblacion, limitesMin, limitesMax);

for gen = 1:numGeneraciones
    % Evaluar fitness de cada individuo en la población
    fitness = evaluarFitnessCompleto(poblacion, imgHSV, maskReferencia, img);

    % Mostrar el mejor fitness en cada generación
    disp(['Generación ' num2str(gen) ': Mejor Fitness = ' num2str(max(fitness))]);

    % Selección y creación de una nueva población
    nuevaPoblacion = [];
    for i = 1:tamanoPoblacion / 2
        % Selección
        [padre1, padre2] = seleccionarPadres(poblacion, fitness);
        % Cruce
        [hijo1, hijo2] = cruce(padre1, padre2);
        % Mutación
        hijo1 = mutar(hijo1, limitesMin, limitesMax, probMutacion);
        hijo2 = mutar(hijo2, limitesMin, limitesMax, probMutacion);
        % Añadir hijos a la nueva población
        nuevaPoblacion = [nuevaPoblacion; hijo1; hijo2];
    end

    % Actualizar la población
    poblacion = nuevaPoblacion;
end
TimeAG = toc;

% Obtener el mejor individuo después de las generaciones
[Apt_sol, idxMejor] = max(fitness);
mejorIndividuo = poblacion(idxMejor, :);

% Segmentación final con los mejores límites
figure(1);
mask = aplicarFiltro(imgHSV, mejorIndividuo);
imshow(mask);
title('Resultado de Segmentación con AG');
% Parametros de rendimiento
per_sim = norm(mask - BW);
fprintf('Tiempo: %.6f Aptitud: %.7f  Generaciones: %d  Similitud: %.4f \n', TimeAG, Apt_sol, numGeneraciones, per_sim);