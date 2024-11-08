% esta es la propuesta metodo de cruza para AGs, propuesta por Jose Petion,
% basado en el concepto de cruza de puntos fijos
function [prog_1, prog_2] = crossover2(parent1, parent2, mask, Pc)
    % lambdas
    A_1 = Pc;
    A_2 = 1 - Pc;
    
    % Extraer las filas exceptuando la primera y la última
    C_sub = parent1(2:end-1, :);
    Cr_sub = parent2(2:end-1, :);

    % Inicializar la variable para almacenar los resultados
    resultado = zeros(size(C_sub));

    % Aplicar las operaciones según la máscara
    for i = 1:length(mask)
        if mask(i) == 1
            resultado(i, 1) = A_1 * C_sub(i, 1) + A_1 * Cr_sub(i, 1);
            resultado(i, 2) = A_2 * C_sub(i, 2) + A_2 * Cr_sub(i, 2);
        else
            resultado(i, 1) = A_2 * C_sub(i, 1) + A_2 * Cr_sub(i, 1);
            resultado(i, 2) = A_1 * C_sub(i, 2) + A_1 * Cr_sub(i, 2);
        end
    end

    % Crear la variable final "pr1"
    prog_1 = {[parent1(1, :); resultado; parent1(end, :)]};

    for i = 1:length(mask)
        if mask(i) == 0
            resultado(i, 1) = A_1 * C_sub(i, 1) + A_1 * Cr_sub(i, 1);
            resultado(i, 2) = A_2 * C_sub(i, 2) + A_2 * Cr_sub(i, 2);
        else
            resultado(i, 1) = A_2 * C_sub(i, 1) + A_2 * Cr_sub(i, 1);
            resultado(i, 2) = A_1 * C_sub(i, 2) + A_1 * Cr_sub(i, 2);
        end
    end

    % Crear la variable final "pr1"
    prog_2 = {[parent2(1, :); resultado; parent2(end, :)]};

end