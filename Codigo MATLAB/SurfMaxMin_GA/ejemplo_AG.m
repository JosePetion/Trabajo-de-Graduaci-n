%% Universidad del Valle de Guatemala
% Modificado por: Jose Pablo Petion Rivas
% Autor: UNAM, Cómputo evolutivo, Katya Rodríguez Vázquez
% Enlace: https://www.coursera.org/learn/computo-evolutivo
% Implementación de algoritmo Genético basico para Maximización de
% superficies 3D. Este algoritmo consta de la definición de diferentes
% funciones para econtrar sus mínimos. Fué modificado para validar su
% estructura básica.
% ------------------------------------------------------------------------
% Codificación binaria de las variables
% la función nos devuelve, la longitud de cuantos bits codificados
height_x = bin_cod_height(4, -3.0, 12.1);
height_y = bin_cod_height(4, 4.1, 5.8); 
% ------------------------------------------------------------------------
% Algoritmo Genéticoç
funcion = "hiperbola";  % Variar la función a gusto
tic;
N_ind = 100;    % número de individuos en la población
L_ind = 20;     % longitud de individuos 
Pc = 0.9;       % Probabilidades de cruza
Pm = 0.01;      % Probabilidad de mutación
Max_gen = 100;  % Máximo de generaciones
N_var = 2;      % numero de vairbales
rango = [-5 -5;
          5  5]; % rango de las varibales del problema en estudio x & y
Mejor = NaN*ones(Max_gen,1);                    % Almacena mejorxpoblación
Mejor_cromosoma =  zeros(N_ind, L_ind);   % Almacena mejores indiv,
% generación de población
genotipo = creapob(N_ind, L_ind);
% decodificación 
fenotipo = decodifica(genotipo, rango);
% evaluación de función objetivo
objv = objfun(fenotipo, funcion);
% inicio de cruze
generaciones = 1;
stop = 1;
old = 0;
old1 = 0;
error = 0;
figure(1);
while (generaciones < Max_gen) && stop
    aptitud = rankeo(objv, 1); % Evalua el valor mas alto o bajo en función
    nuevo_gen = ruleta(genotipo, fenotipo, aptitud);
    nuevo_gen = xunpunto(nuevo_gen, Pc);
    nuevo_gen = muta(nuevo_gen, Pm);
    nuevo_feno = decodifica(nuevo_gen, rango);
    nuevo_objv = objfun(nuevo_feno,funcion);
    genotipo = nuevo_gen; 
    objv = nuevo_objv;
    [valor , idx] = max(objv);
    Mejor(generaciones) = valor;
    Mejor_cromosoma(generaciones, :) = genotipo(idx, :);
    plot((Mejor),'ro'); xlabel('generaciones'); ylabel('Mejor solución');
    text(0.5, 0.95, ['Mejor = ', num2str(Mejor(generaciones))], 'Units',...
        'normalized');
    drawnow;
    if generaciones >= 4
        if (Mejor(generaciones)+Mejor(generaciones-1)+Mejor(generaciones-2)+Mejor(generaciones-3))/4 == Mejor(generaciones)
            stop = 0;
        end 
    end
    generaciones = generaciones + 1;
end
tiempo = toc;
% -------------------------------------------------------------------------
% Se grafican las funciones para revisión visual
switch funcion
    case "paraboloide"
        [xv, yv] = meshgrid(linspace(rango(1,1), rango(2,1),100), linspace(rango(1,2), rango(2,2), 100));
        f = @(x, y) -x.^2 - y.^2 + 5;
        z = f(xv,yv);
        figure(2);
        surf(xv, yv, z);
    case "sombrero"
        [xv, yv] = meshgrid(linspace(rango(1,1), rango(2,1),100), linspace(rango(1,2), rango(2,2), 100));
        f = @(x, y) sin(sqrt(x.^2 + y.^2)) - 0.1 * (x.^2 + y.^2);
        z = f(xv,yv);
        figure(2);
        surf(xv, yv, z);
        xlabel("x");
        ylabel("y");
        zlabel("z");
        title("Sombrero")
    case "hiperbola"
        [xv, yv] = meshgrid(linspace(rango(1,1), rango(2,1),100), linspace(rango(1,2), rango(2,2), 100));
        f = @(x, y) x.^2 + y.^2 + x + y +x.*y;
        z = f(xv,yv);
        figure(2);
        surf(xv, yv, z);
        xlabel("x");
        ylabel("y");
        zlabel("z");
        title("Paraboloide elíptico")
end

fprintf("Tiempo: %.4f Valor min, max: %.4f Iter: %d", tiempo,Mejor(generaciones-1), generaciones);