function [x_lim, y_planes, z_lim] =  map_trace(map)

n = map(1);
m = map(2);
k = map(3);
% Coordenadas de los tres planos (paredes)
x_lim = [0, map(1)/2; map(1)/2, map(1); 0, map(1)/2];  % Limitar en el eje X hasta n/3
y_planes = [map(2)/4, map(2)/2, 3*map(2)/4];  % Posiciones en Y para las tres "paredes"
z_lim = [0, k; 0, k; 0, k];

% Crear la figura
figure();
hold on;
grid on;
axis([0 n 0 m 0 k]);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Mapa de exploración en espacio 3D');
view(3);  % Vista 3D
% Crear los tres planos (paredes)
for i = 1:length(y_planes)
    % Definir los vértices de la "pared" en la posición y_planes(i)
    vertices = [
        x_lim(i,1), y_planes(i), 0;
        x_lim(i,2), y_planes(i), 0;
        x_lim(i,2), y_planes(i), k;
        x_lim(i,1), y_planes(i), k];
    % Conexiones para formar una cara rectangular
    faces = [1 2 3 4];
    % Crear el plano como un objeto patch
    patch('Vertices', vertices, 'Faces', faces, ...
          'FaceColor', 'cyan', 'FaceAlpha', 0.3, 'EdgeColor', 'black');
end

hold off;

end