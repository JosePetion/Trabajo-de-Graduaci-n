% Cruce entre dos padres (cruce uniforme)
function [hijo1, hijo2] = cruce(padre1, padre2)
    mask = rand(1, 6) > 0.5;  % Mascara de cruce uniforme
    hijo1 = padre1;
    hijo2 = padre2;
    hijo1(mask) = padre2(mask);
    hijo2(mask) = padre1(mask);
end