% Selección de padres mediante torneo
function [padre1, padre2] = seleccionarPadres(poblacion, fitness)
    indices = randi(length(fitness), 2, 2);  % Selección aleatoria de índices para el torneo
    [~, idx1] = max(fitness(indices(:, 1)));  % Mejor de los primeros
    [~, idx2] = max(fitness(indices(:, 2)));  % Mejor de los segundos
    padre1 = poblacion(indices(idx1, 1), :);
    padre2 = poblacion(indices(idx2, 2), :);
end