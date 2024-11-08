% Esta funcion calcula la distancia por medio de una proyección vectorial
% de tal manera que no falle con el metodo de 
function obst_distances = obs_dist(population, y_points, n_points)
        obst_distances = cell(1, size(y_points, 1));
        n_obstacle = zeros(size(population,1),n_points-1);
        distances = zeros(n_points-1, 1);
        for k = 1:size(y_points, 1)
            x3 = y_points(k,1);
            y3 = y_points(k,2);   
            for i = 1:size(population,1)
                array_points = population{i};
                for j = 1:(size(distances,1))
                    
                    x1 = array_points(j, 1);
                    y1 = array_points(j, 2);
                    x2 = array_points(j+1, 1);
                    y2 = array_points(j+1, 2);
                    % Puntos vectoriales
                    P1 = [x1, y1]; % Ejemplo: [1, 2]
                    P2 = [x2, y2]; % Ejemplo: [4, 6]
                    P3 = [x3, y3];
                    % punto del obstaculo
                    % Vector del segmento P1P2
                    v = [x2 - x1, y2 - y1];
                    % Vector del segmento P1P3
                    w = [x3 - x1, y3 - y1];
                    % Proyección escalar de w en v
                    c1 = dot(w, v);
                    c2 = dot(v, v);
                    % Parámetro de la proyección en el segmento
                    t = c1 / c2;
                    if t < 0.0
                        % El punto más cercano está en P1
                        closest_point = P1;
                    elseif t > 1.0
                        % El punto más cercano está en P2
                        closest_point = P2;
                    else
                        % El punto más cercano está en el segmento
                        closest_point = P1 + t * v;
                    end

                    % Calcular la distancia mínima
                    % Calcular la distancia
                    distances(j) = norm(P3 - closest_point);
                end
                n_obstacle(i,:) = distances';
            end
            obst_distances{k} = n_obstacle;
            end
end