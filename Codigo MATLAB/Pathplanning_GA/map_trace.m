function map_trace(fitness, population, obstacles, map_size, radio)
    %figure(1);clf;
    % comentar en caso no querer ver todas las lineas
%     for i = 1:size(population, 1)
%             crom = population{i};
%             xa = crom(:, 1);
%             ya = crom(:, 2);
%             plot(xa, ya, 'y-o');
%             hold on;
%     end
    
    % Comienzo del ploteo
    [fitness_val, position] = max(fitness);
    cromosome = population{position};
    x = cromosome(:, 1);
    y = cromosome(:, 2);
    
    % Osbtaculos
    theta = linspace(0, 2*pi, 100);
    for i = 1:size(obstacles,1)
        xcircle = radio * cos(theta) + obstacles(i, 1); % Coordenadas x del círculo
        ycircle = radio * sin(theta) + obstacles(i, 2); % Coordenadas y del círculo
        plot(xcircle, ycircle, 'k-', 'LineWidth', 1.5); % Dibuja el círculo
        hold on;
    end
    % plot(x, y, 'b-o', 'LineWidth', 1); % Grafica la línea con un marcador en cada punto
    
    % Añade etiquetas y título
    xlabel('coordenada X');
    ylabel('coordenada Y');
    xlim([0, map_size])
    ylim([0, map_size])
    title('Mejores Cromosomas x Población');
    grid on;
    %hold on;
end