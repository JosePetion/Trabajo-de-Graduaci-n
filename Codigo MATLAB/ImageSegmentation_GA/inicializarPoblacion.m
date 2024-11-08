% Inicializar población con individuos aleatorios
function poblacion = inicializarPoblacion(tamanoPoblacion, limitesMin, limitesMax)
    poblacion = rand(tamanoPoblacion, 6);  % Inicializar aleatoriamente
    % Escalar individuos a los límites min y max
    for i = 1:6
        poblacion(:, i) = poblacion(:, i) * (limitesMax(i) - limitesMin(i)) + limitesMin(i);
    end
end