function fitness = evaluarFitnessCompleto(poblacion, imgHSV, maskReferencia, imgOriginal)
    tamanoPoblacion = size(poblacion, 1);
    fitness = zeros(tamanoPoblacion, 1);
    edgesOriginal = edge(rgb2gray(imgOriginal), 'Canny');
    
    for i = 1:tamanoPoblacion
        limites = poblacion(i, :);
        mask = aplicarFiltro(imgHSV, limites);
        
        % IoU entre la máscara generada y la máscara de referencia
        interseccion = sum(mask & maskReferencia, 'all');
        union = sum(mask | maskReferencia, 'all');
        iou = interseccion / union;
        
        % Coincidencia de bordes
        edgesMask = edge(mask, 'Canny');
        coincidenciaBordes = sum(edgesOriginal & edgesMask, 'all') / sum(edgesOriginal, 'all');
        
        % Fitness total, ponderando IoU y coincidencia de bordes
        fitness(i) = 0.7 * iou + 0.3 * coincidenciaBordes;
    end
end