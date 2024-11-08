function import_trayectory(points, n)
    % Supongamos que trayectoria es una matriz de tamaño 100x3
    points = points / 100;     % Escalar en metros
    points(:, 1:2) = points(:, 1:2) - 1;  % Desfase de 0.5 metros solo en x e y

    % Interpolación de cada columna (x, y, z) de los puntos
    t_original = linspace(0, 1, size(points, 1)); % Escala para los puntos originales
    t_interp = linspace(0, 1, n); % Escala para los puntos interpolados

    % Interpolación
    interp_x = interp1(t_original, points(:,1), t_interp, 'linear');
    interp_y = interp1(t_original, points(:,2), t_interp, 'linear');
    interp_z = interp1(t_original, points(:,3), t_interp, 'linear');

    % Combina las coordenadas interpoladas en una matriz n x 3
    interpolated_points = [interp_x', interp_y', interp_z'];
    save_path = 'D:\Jose Pablo Petion\Documents\S2 - Quinto año\Diseño e innovacion en ingenieria 2\Trabajo de graduacion\Webots\PathPlanning3Ddrone\webots\controllers\test_controller\trajectory.txt'
    % Guardar en un archivo .txt
    writematrix(interpolated_points, save_path, 'Delimiter', 'tab');
    figure();
    plot3(interp_x, interp_y, interp_z, 'r-o', 'LineWidth', 0.5)
end