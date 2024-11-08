function population = generate_initial_population(n, x_range, y_range)
    % Validar que los rangos son vectores de longitud 2
    if length(x_range) ~= 2 || length(y_range) ~= 2
        error('Los rangos deben ser vectores de longitud 2');
    end
    
    % Generar valores aleatorios para las coordenadas x e y
    x_values = x_range(1) + (x_range(2) - x_range(1)) * rand(n, 1);
    y_values = y_range(1) + (y_range(2) - y_range(1)) * rand(n, 1);
    
    % Combinar los valores de x e y en una sola matriz
    population = [x_values, y_values];
end
