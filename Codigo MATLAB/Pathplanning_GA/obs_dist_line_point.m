function obst_distances = obs_dist_line_point(population,obstacles, n_points)
        obst_distances = cell(1, size(obstacles, 1));
        n_obstacle = zeros(size(population,1),n_points-1);
        distances = zeros(n_points-1, 1);
        for k = 1:size(obstacles, 1)
            x3 = obstacles(k,1);
            y3 = obstacles(k,2);   
            for i = 1:size(population,1)
                array_points = population{i};
                for j = 1:(size(distances,1))
                    x1 = array_points(j, 1);
                    y1 = array_points(j, 2);
                    x2 = array_points(j+1, 1);
                    y2 = array_points(j+1, 2);
                    % punto del obstaculo

                    % Convertir a la forma Ax + By + C = 0
                    A = -(y2 - y1);
                    B = x2 - x1;
                    C = x1*(y2 - y1) - y1*(x2 - x1);
                    % Calcular la distancia
                    distances(j) = abs(A * x3 + B * y3 + C) / sqrt(A^2 + B^2);
                end
                n_obstacle(i,:) = distances';
            end
            obst_distances{k} = n_obstacle;
        end
end