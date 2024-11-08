function e_distance = euclidian(population, pop_size, n_points)
    e_distance = zeros(pop_size, n_points-1);
    distances = zeros(n_points-1, 1);
    for i = 1:pop_size
        % extraemos la primera celda no.i
        points_array = population{i};
        % inicializamos el vector que guarda distancias
        for j = 1:(size(distances,1))
            distances(j) = sqrt((points_array(j+1, 1) - points_array(j, 1))^2 + (points_array(j+1, 2) - points_array(j, 2))^2);
        end 
        e_distance(i, :) = distances';
    end
    
end