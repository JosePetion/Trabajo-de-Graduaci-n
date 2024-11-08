function obs_check = check_colision(Population, npoints, ylim, xlim, zlim)
    obs_check = zeros(size(Population,1), 1);
    obstacle = zeros(npoints-1, size(ylim, 2)); %Obst x Line seg. 
    for i = 1:size(Population,1) % Ciclo que selecciona individuo N#
        crom = Population{i}; 
        for j = 1:npoints-1;
            p1 = crom(j, :);
            p2 = crom(j+1, :);
            for k = 1:size(ylim,2)
                % Procedimiento del obstáculo
                % - - - -- - -  - - - - - - -
                x_min = xlim(k,1);
                x_max = xlim(k,2);
                z_min = zlim(k,1);
                z_max = zlim(k,2);
                c = ylim(k);
                t = (c - p1(2)) / (p2(2) - p1(2));
                if t >= 0 && t <= 1
                    % Paso 3: Calcular el punto de intersección
                    x_intersect = (1 - t) * p1(1) + t * p2(1);
                    y_intersect = c; % Por definición del plano
                    z_intersect = (1 - t) * p1(3) + t * p2(3);

                    % Paso 4: Verificar si el punto de intersección está dentro de los límites
                    if (x_intersect > x_min && x_intersect < x_max) && ...
                       (z_intersect > z_min && z_intersect < z_max)
                        obstacle(j,k) = 1;
                    else
                        obstacle(j,k) = 0;
                    end
                else
                    obstacle(j,k) = 0;
                end
                % Procedimiento del obstáculo
                
            end
        end
        obs_val = sum(sum(obstacle, 2)',2);
        obs_check(i) = obs_val;
    end
    
end