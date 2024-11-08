function array = do_array(points, res)
    % Número de puntos intermedios entre cada par de puntos
    % Crear un vector de parámetros para los puntos originales (en este caso, simplemente los índices)
    t = 1:size(points, 1);

    % Crear un vector de parámetros para los puntos interpolados
    t_interp = linspace(1, size(points, 1), res);

    % Interpolación spline para obtener una curva suave
    x_interp = spline(t, points(:, 1), t_interp);
    y_interp = spline(t, points(:, 2), t_interp);

    % Combinar los puntos interpolados en una matriz
    array = [x_interp', y_interp'];
    
    % Mostrar los puntos de la trayectoria
    % disp('Puntos de la trayectoria:');
    % disp(array);

    % Graficar los puntos y la trayectoria
    figure(3);clf;
    plot(points(:,1), points(:,2), 'ro-', 'MarkerSize', 10);  % Puntos originales
    hold on;
    plot(array(:,1), array(:,2), 'b.-');  % Trayectoria
    title('Trayectoria entre los puntos');
    xlabel('X');
    ylabel('Y');
    legend('Puntos originales', 'Trayectoria');
    grid on;
    hold off;
    
    
end