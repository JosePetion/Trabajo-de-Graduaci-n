%% UNIVERSIDAD DEL VALLE DE GUATEMALA
% Trabajo de graduación
% Autor: Jose Pablo Petion Rivas
% Año: 2024
% Descripción:
% Código de implementación de Algoritmos genéticos para búsqueda de
% trayectoria libre de obstáculos planos en un entorno 3D. Este código
% puede ser aplicado junto a las herramientas de simulación Webots en
% compañia de un Dron Crazyflie.
%% Parametros de simulación
% Crearemos el mapa
rng('shuffle');
mapSize = [200, 200, 80];
% Revisamos el escenario de prueba
xlim = [0, mapSize(1)/2; mapSize(1)/2, mapSize(1); 0, mapSize(1)/2];
ylim = [mapSize(2)/4, mapSize(2)/2, 3*mapSize(2)/4];
zlim = [0, mapSize(3); 0, mapSize(3); 0, mapSize(3)];
% Defina el punto de inicio y meta
Ps = [ 20,  5, 15];
Pg = [195, 195, 70];
% Algoritmo Genetico
% Parametros de simulación
Pop_size = 30;
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
clear i;
% Observar las trayectorias de la primera población
% - - - - - - - - Verificación de colisión con obstaculos - - - - - - - -
% Paso 1 calcular la distancia entre dos puntos con norma eculidiana
e_distances = euclidian(population, Pop_size, n_points);
% Paso 2 determinar si las rectas colisionan con los obtáculos
colision_check = check_colision(population, n_points, ylim, xlim, zlim);
% Paso 3 primera evaluación de función aptitud
Aptitud = fitness(e_distances, colision_check);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%% Sección de cruza para toda una generación
best_apt = zeros(n_gen, 1);
best_crom = cellfun(@(x) zeros(n_points, 3), cell(Pop_size, 1), 'UniformOutput', false);
best_dist = zeros(n_gen, 1);
j = 1;
varianza = 1;
new_population = cell(Pop_size, 1);
while j <= n_gen && varianza ~= 0    
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
        % Obtengo a los padres # 19
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
        chk_h1 = check_colision(hijo1, n_points, ylim, xlim, zlim);
        chk_h2 = check_colision(hijo2, n_points, ylim, xlim, zlim);
        fit_h1 = fitness(dis_h1,chk_h1);
        fit_h2 = fitness(dis_h1,chk_h2);
        
        % - - - - - - - Mutación - - - - - - - -
        Pm = 0.15;
        Pmm = round(rand,1);     
        cadena_mutacion = mutation_rulette(Pm, Pmm, n_points);
        % - - - - - - Método de selección - - - -
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
        progenies_distance = euclidian(progenies, size(progenies, 1),...
                                       n_points);
        progenies_check = check_colision(progenies, n_points, ylim, xlim,zlim);
        Aptitud_progenies = fitness(progenies_distance, progenies_check);
        
        [~, posicion1] = max(Aptitud_progenies);
        Aptitud_progenies(posicion1) = -Inf;
        [~, posicion2] = max(Aptitud_progenies);
        % Agregamos a los mejores progenitores a la nueva población
        new_population{i} = progenies{posicion1};
        new_population{i+1} = progenies{posicion1};
        
    end
    population = new_population;
    e_distances = euclidian(population, Pop_size, n_points);
    obs_check = check_colision(population, n_points, ylim, xlim, zlim);
    Aptitud = fitness(e_distances, obs_check);
    [best_apt(j), lugar] = max(Aptitud);
    best_dist(j) = e_distances(lugar);
    best_crom{j} = population{lugar};
    % - - - - - Condición de detención - - - - - - 
    % En dado caso no querer simplemente comentar
%     if j > 5
%         ind_anterior = best_crom{j-1};
%         ind_nuevo = best_crom{j};
%         varianza = norm(ind_nuevo-ind_anterior);
%     end
    % - - - - - - - - - - - - - - - - - - - - - - -
    j = j+1;
end
TimeAG = toc;
%% - - - - - - - - - - - ---------------------------------------
% Se grafica el mapa y los mejores individuos de cada generación
[xlim, ylim, zlim] = map_trace(mapSize);
hold on;
cromTrace(best_crom);
hold off;
% - - - - - Extracción de mejor individuo - - - - - - -
% Aqui seleccionamos al mejor individuo
[Apt_sol, best_pos] = max(best_apt);
best_sol = {best_crom{best_pos}};
solution = best_crom{best_pos}; 
[xlim, ylim, zlim] = map_trace(mapSize);
hold on;
cromTrace(best_sol)
fprintf('Tiempo: %.6f Aptitud: %.7f Distancia: %.3f Generaciones: %d \n', TimeAG, Apt_sol, min(best_dist), j-1);
% Para fines de uso en simulaciones, se crea un archivo ".txt" que contiene
% la trayectoria que deberia seguir mapeada a dimensiones en Webots.
import_trayectory(solution, 50);
