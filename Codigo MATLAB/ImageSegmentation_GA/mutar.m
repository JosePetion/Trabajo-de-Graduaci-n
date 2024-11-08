% Mutación de un individuo
function individuo = mutar(individuo, limitesMin, limitesMax, probMutacion)
    for i = 1:length(individuo)
        if rand < probMutacion
            % Aplicar una mutación aleatoria dentro del rango permitido
            individuo(i) = limitesMin(i) + (limitesMax(i) - limitesMin(i)) * rand;
        end
    end
end