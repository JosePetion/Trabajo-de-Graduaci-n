function map_trace2(n, m, k)
    % Definir dimensiones del espacio
    % Definir las coordenadas para los planos paralelos al plano zy
    % Los planos estarán en 0 < x < n/3 y acotados en el eje z de 0 a k.
    x1_lim = [0, n/2];
    x2_lim = [n/2, n];
    x3_lim = [0, n/2];          
    y_planes = [20, 50, 80];    % Coordenadas y_o donde colocamos los planos
    % Crear la figura
    figure(1);clf;
    hold on;
    grid on;
    % Definir el rango de z (altura)
    z = linspace(0, k, 50); % 50 puntos en el eje z
    [X1, Z1] = meshgrid(x1_lim, z);  % Crear malla para x y z
    [X2, Z2] = meshgrid(x2_lim, z);
    [X3, Z3] = meshgrid(x3_lim, z);
    Y1 = y_planes(1) * ones(size(X1));  % Fijar la coordenada y (y_o)
    Y2 = y_planes(2) * ones(size(X2));
    Y3 = y_planes(3) * ones(size(X3));
    surf(X1, Y1, Z1);  % Graficar el plano
    surf(X2, Y2, Z2);
    surf(X3, Y3, Z3);
    % Ajustar los ejes
    xlim([0 n]);
    ylim([0 m]);
    zlim([0 k]);
    % Etiquetas de los ejes
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title('Mapa 3D con muros');
    view(3);  % Vista 3D
    hold off;
end