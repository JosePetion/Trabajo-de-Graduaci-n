function objv = objfun(fenotipo, funcion);
[N_ind, N_var] = size(fenotipo);
for i = 1:N_ind
    % Función de parabolide
    if funcion == "paraboloide"
    objv(i,1) = -fenotipo(i,1)^2 - fenotipo(i,2)^2 + 5;
    % Función de ondulación
    elseif funcion == "sombrero"
     objv(i,1) = sin(sqrt(fenotipo(i,1).^2 + fenotipo(i,2).^2))-0.1*(fenotipo(i,1).^2 + fenotipo(i,2).^2);
    elseif funcion == "hiperbola"
    % Funcion hiperbola
     objv(i,1) = fenotipo(i,1).^2 + fenotipo(i,2).^2 + fenotipo(i,1) + fenotipo(i,2) + fenotipo(i,1)*fenotipo(i,2);
    end
end