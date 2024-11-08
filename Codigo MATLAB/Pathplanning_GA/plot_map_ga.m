function plot_map_ga(poblacion)
    for i = 1:size(poblacion, 1)
        cromosoma = poblacion{i};
        x = cromosoma(:, 1);
        y = cromosoma(:, 2);
        plot(x, y, 'r-o', 'LineWidth', 0.5)
    end
end