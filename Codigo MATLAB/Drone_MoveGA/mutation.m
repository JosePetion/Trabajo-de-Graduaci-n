
function [progeny1, progeny2] = mutation(padre1, padre2, mask, Pmm)
    % definimos los valores lambda
    A_1 = Pmm;
    A_2 = 1-Pmm;
    % extraemos los valores en x & y
    C_sub = padre1(2:end-1, :);
    Cr_sub = padre2(2:end-1, :);
    % creamos un vector que almacene los puntos intermedios
    resultado = zeros(size(C_sub));
    % Hacemos la cruza aritmética con el porcentaje de mutación
    for i = 1:length(mask)
        if mask(i) == 1
            resultado(i, 1) = A_1 * C_sub(i, 1) + A_1 * Cr_sub(i, 1);
            resultado(i, 2) = A_2 * C_sub(i, 2) + A_2 * Cr_sub(i, 2);
            resultado(i, 3) = A_1 * C_sub(i, 3) + A_1 * Cr_sub(i, 3);
        else
            resultado(i, 1) = C_sub(i, 1);
            resultado(i, 2) = C_sub(i, 2);
            resultado(i, 3) = C_sub(i, 3);
        end
    end
    progeny1 = {[padre1(1, :); resultado; padre1(end, :)]};
    
    for i = 1:length(mask)
        if mask(i) == 1
            resultado(i, 1) = A_2 * C_sub(i, 1) + A_2 * Cr_sub(i, 1);
            resultado(i, 2) = A_1 * C_sub(i, 2) + A_1 * Cr_sub(i, 2);
            resultado(i, 3) = A_2 * C_sub(i, 3) + A_2 * Cr_sub(i, 3);
        else
            resultado(i, 1) = Cr_sub(i, 1);
            resultado(i, 2) = Cr_sub(i, 2);
            resultado(i, 3) = Cr_sub(i, 3);
        end
    end

    % Crear la variable final "pr1"
    progeny2 = {[padre2(1, :); resultado; padre2(end, :)]};
end