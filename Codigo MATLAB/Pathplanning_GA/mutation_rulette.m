function mutation_point = mutation_rulette(Pm, Pmm, n_points)

    base = n_points-2;
    binary = ones(1, base);
    % Convierte el vector numérico a cadena de caracteres
    cadena_binaria = num2str(binary);
    cadena_binaria = cadena_binaria(~isspace(cadena_binaria)); % Elimina espacios
    % Convierte la cadena binaria a valor decimal
    Multiplo = bin2dec(cadena_binaria);
    if Pmm < Pm
        rand_point = rand;
        value_bin = pad(dec2bin(ceil(Multiplo*rand_point)), n_points-2, 'left', '0');
        mutation_point  = value_bin - '0';
    else
        mutation_point = zeros(1, base);
    end
    
end