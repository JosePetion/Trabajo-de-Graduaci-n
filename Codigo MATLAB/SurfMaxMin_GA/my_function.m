% Definir la función original
function f = my_function(x)
    % f = 21.5 + x(1)*sin(4*pi*x(1)) + x(2)*sin(20*pi*x(2));  % Ejemplo de función a maximizar
    f = x(1)^2 + x(2)^2 + x(1) + x(2) + x(1)*x(2);
end