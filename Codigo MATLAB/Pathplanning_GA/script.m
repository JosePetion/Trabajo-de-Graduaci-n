%% UNIVERSIDAD DEL VALLE DE GUATEMALA
% Trabajo de graduación
% Autor: Jose Pablo Petion Rivas
% Año: 2024
% Descripción:
% Implementación de algoritmo genñetico para planificación de trayectorias
% en mapas 2D. El algoritmo tiene como objetivo buscar una trayectoria
% libre de obstáculos. Esta implementación puede simularse en webtos con un
% robot diferencial junto a un controlador de pose lineal.
%% Parametros de simulación
% Crearemos el mapa
mapSize = 200;
map = zeros(mapSize);
% Se define la coordenada del obstaculo y su radio
% - - - - - - - - - - -Terreno por paredes - - - - - - - - - - - - - - -
obstacleCenter = [10,50; 15,50; 20,50; 25,50; 30,50; 35,50;...
                  40,50; 45,50; 50,50; 55,50; 60,50; 65,50;...
                  40,50; 45,50; 50,50; 55,50; 60,50; 65,50;...
                  70,50; 75,50; 80,50; 85,50; 90,50; 95,50;...
                  100, 100; 105,100; 110,100; 115,100; 120,100;...
                  125, 100; 130,100; 135,100; 140,100; 145,100;...
                  150, 100; 155,100; 160,100; 165,100; 170,100;...
                  175, 100; 180,100; 185,100; 190,100; 195,100;...
                  10,170; 15,170; 20,170; 25,170; 30,170; 35,170;...
                  40,170; 45,170; 50,170; 55,170; 60,170; 65,170;...
                  40,170; 45,170; 50,170; 55,170; 60,170; 65,170;...
                  70,170; 75,170; 80,170; 85,170; 90,170; 95,170; 5,50;];
% - - - - - - - - - - - obstáculos normales - - - - - - - - - - - - - - -
% obstacleCenter = [85,100;   25, 50; 30, 120;   60,110;  60,20;   70,70;...
%                  110,20; 110, 135; 110, 90];%  90, 80; 190,100; 147,160;...
%                   140, 80];
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
obstacleRadius = 5;
Ps = [ 20,  20];
Pg = [195, 195];
%% Algoritmo Genetico
% Parametros de simulación
Pop_size = 50;
n_gen = 100;        % iteraciones    
% - - - - - - - - - - - - 
% Parametros del cromosoma y la población
n_points = 6; % no. de puntos en el mapa
population = cell(Pop_size, 1);
% Inicio del AG
tic;
% función que crea la poblacion como una celda
for i = 1:Pop_size
    population{i} = generate_pob(Ps, Pg, n_points);
end
% - - - - - - - - - - - - - - - - - - - -
% Verificación de colisión con obstaculos
% - - - - - - - - - - - - - - - - - - - -
% paso 1 calcular la distancia entre dos puntos con norma eculidiana
% Distancia euclidiana en forma de vector con n distancias
e_distances = euclidian(population, Pop_size, n_points);
% Norma de la distancia euclidiana
norm_e_distances = sum(e_distances, 2);
% paso 2 encontrar la eucación de la recta entre puntos
% para luego encontrar la distancia entre la recta y el obstáculo.
% La funcion obs_dist encuentra la ecuacion de la recta para el cromosoma
% y luego en base a las constantes de la recta obtiene la distancia de la 
% linea perpendicular entre la recta y el obstáculo (se debe conocer la
% coordenada del obstaculo).
obst_distances = obs_dist(population,obstacleCenter,n_points);
% Obstacles check verifique cuales trayectorias tienen obstaculos
obs_check = check_colision(obstacleCenter, Pop_size, obstacleRadius, obst_distances);
% - - - - - - - - - - - - - - - - - -
% Paso 3 primera evaluación de función aptitud
Aptitud = fitness(norm_e_distances, obs_check);
% - - - - - - - - - - - - - - - - - -
% Paso 3 verificar la grafica con el obstáculo
% figure(1);
% map_trace(Aptitud, population, obstacleCenter, mapSize, obstacleRadius);
% hold on;
% - - - - - - - - - - - - - - - - - -
%% Sección de cruza para toda una generación
best_apt = zeros(n_gen, 1);
best_crom = cell(n_gen, 1);
best_dist = zeros(n_gen, 1);
j = 1;
new_population = cell(Pop_size, 1);
while j <= n_gen    
    for i = 1:2:Pop_size
        % - Seleccion de padres - 
        % Buscamos el cromosoma con mayor Aptitud
        [fit_p1, posicion1] = max(Aptitud);
        % Buscamos un cromosoma random
        posicion2 = randi([1,size(population,1)]);
        fit_p2 = Aptitud(posicion2);
        % Nos aseguramos que no se repetira con el padre 1
        while posicion1 == posicion2
            posicion2 = randi([1,size(population,1)]);
        end
        Padre1 = population{posicion1};
        Padre2 = population{posicion2};

        % - Ruleta giratoria -
        % Puntos de cruce
        cadena_cruza = rulette(n_points);
        Pc = round(rand,1);
        % - Cruze aritmetico
        [hijo1, hijo2] = crossover(Padre1, Padre2, cadena_cruza, Pc);
        % - Comparacion de aptirud padre/hijo -
        dis_h1 = euclidian(hijo1,1,n_points);
        dis_h2 = euclidian(hijo2,1,n_points);
        nor_h1 = sum(dis_h1, 2);
        nor_h2 = sum(dis_h2, 2);
        ODs_h1 = obs_dist(hijo1,obstacleCenter,n_points);
        ODs_h2 = obs_dist(hijo2,obstacleCenter,n_points);
        chk_h1 = check_colision(obstacleCenter, 1, obstacleRadius, ODs_h1);
        chk_h2 = check_colision(obstacleCenter, 1, obstacleRadius, ODs_h2);
        fit_h1 = fitness(nor_h1,chk_h1);
        fit_h2 = fitness(nor_h2,chk_h2);
        
% - - - - - - - Mutación - - - - - - - -
        Pm = 0.15;
        Pmm = round(rand,1);     
        cadena_mutacion = mutation_rulette(Pm, Pmm, n_points);
        
        % Caso en que Hijo 1 es mejor que el padre, pero hijo 2 no
        if fit_h1 > fit_p1 && fit_h2 < fit_p2 
            hijo2{1} = Padre2;
            [hijo3,hijo4] = mutation(Padre2,...
                population{randi([1,size(population,1)])},...
                cadena_mutacion, Pmm);
            progenies = {hijo1{1}; hijo2{1}; hijo3{1}; hijo4{1}};
        % Caso en que Hijo 2 es mejor que el padre, pero hijo 1 no    
        elseif fit_h1 < fit_p1 && fit_h2 > fit_p2
            hijo1{1} = Padre1;
            [hijo3,hijo4] = mutation(Padre1,...
                population{randi([1,size(population,1)])},...
                cadena_mutacion, Pmm);
            progenies = {hijo1{1}; hijo2{1}; hijo3{1}; hijo4{1}};
        % Caso en que Hijo 1 y 2 no son mejores    
        elseif fit_h1 < fit_p1 && fit_h2 < fit_p2
            hijo1{1} = Padre1;
            hijo2{1} = Padre2;
            [hijo3,hijo4] = mutation(Padre1,...
                population{randi([1,size(population,1)])},...
                cadena_mutacion, Pmm);
            [hijo5,hijo6] = mutation(Padre2,...
                population{randi([1,size(population,1)])},...
                cadena_mutacion, Pmm);
            progenies = {hijo1{1}; hijo2{1}; hijo3{1}; hijo4{1};...
                hijo5{1}; hijo6{1}};
        % caso en que Hijo 1 y 2 son mejores
        elseif fit_h1 > fit_p1 && fit_h2 > fit_p2
                progenies = {hijo1{1}; hijo2{1}};
        
        else
            [hijo1,hijo2] = mutation(Padre1, Padre2,...
                cadena_mutacion, Pmm);
            progenies = {hijo1{1}; hijo2{1}};
        end
            
        % buscamos a los mejores dos individuos de los progenies
        Aptitud_progenies = fitness_cycle(progenies,size(progenies, 1),...
            n_points, obstacleCenter, obstacleRadius);
        
        [~, posicion1] = max(Aptitud_progenies);
        Aptitud_progenies(posicion1) = -Inf;
        [~, posicion2] = max(Aptitud_progenies);
        
        new_population{i} = progenies{posicion1};
        new_population{i+1} = progenies{posicion1};
        
    end
    population = new_population;
    e_distances = euclidian(population, Pop_size, n_points);
    norm_e_distances = sum(e_distances, 2);
    obst_distances = obs_dist(population,obstacleCenter,n_points);
    obs_check = check_colision(obstacleCenter, Pop_size, obstacleRadius, obst_distances);
    Aptitud = fitness(norm_e_distances, obs_check);
    [best_apt(j), lugar] = max(Aptitud);
    best_dist(j) = norm_e_distances(lugar);
    best_crom{j} = population{lugar};
    j = j+1;
end
TimeAG = toc;
%% - - - - - - - - - - Imprimir los resultados - - - - - - - - - - 
figure(1);
map_trace(best_apt, best_crom, obstacleCenter, mapSize, obstacleRadius); 
hold on;
plot_map_ga(best_crom)
hold off;
figure(2);
map_trace(best_apt, best_crom, obstacleCenter, mapSize, obstacleRadius);
title('Mejor Cromosoma');
hold on;
[aptitud, pos_best] = max(best_apt);
mejor_cromosoma = best_crom{pos_best};
xc = mejor_cromosoma(:, 1);
yc = mejor_cromosoma(:, 2);
plot(xc, yc, 'k-o', 'LineWidth', 0.5)
hold off;

fprintf('Tiempo: %.6f Aptitud: %.7f Distancia: %.3f \n', TimeAG, aptitud, min(best_dist))

V_trayectoria = do_array(mejor_cromosoma, 40);