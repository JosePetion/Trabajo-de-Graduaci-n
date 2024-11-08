function dist = euclidean_distance(n, j, x, y)
    % Validar que los índices n y j están dentro de los límites de los vectores x e y
    if n > length(x) || n > length(y) || j > length(x) || j > length(y)
        error('Los índices n o j están fuera de los límites de los vectores x e y');
    end
    
    % Calcular la distancia Euclidiana
    dist = sqrt((x(n) - x(j))^2 + (y(n) - y(j))^2);
end
