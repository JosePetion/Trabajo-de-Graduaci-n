% Aplicar filtro con los límites de color de un individuo en HSV
function mask = aplicarFiltro(imgHSV, limites)
    % Crear una máscara basada en los límites de HSV dados
    mask = (imgHSV(:, :, 1) >= limites(1)) & (imgHSV(:, :, 1) <= limites(2)) & ...
           (imgHSV(:, :, 2) >= limites(3)) & (imgHSV(:, :, 2) <= limites(4)) & ...
           (imgHSV(:, :, 3) >= limites(5)) & (imgHSV(:, :, 3) <= limites(6));
    mask = imfill(mask, 'holes');  % Rellenar agujeros en la máscara
end