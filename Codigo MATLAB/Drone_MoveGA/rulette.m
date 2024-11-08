function value_rw = rulette(N_points)
    % La función nos debe devolver El numero que nos dara el punto de cruza
    base = N_points-2; 
    binary = ones(1, base);
    % Convierte el vector numérico a cadena de caracteres
    cadena_binaria = num2str(binary);
    cadena_binaria = cadena_binaria(~isspace(cadena_binaria)); % Elimina espacios
    % Convierte la cadena binaria a valor decimal
    Multiplo = bin2dec(cadena_binaria);
    % creamos el valor aleatorio para elegir puntos de cruza
    point = rand;
    % Obtenemos la cadena de bits para cruzar
    value_bin = pad(dec2bin(ceil(Multiplo*point)), N_points-2, 'left', '0');
    value_rw  = value_bin - '0';
end