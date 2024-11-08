function fenotipo = decodifica(genotipo,rango)
N_var = size(rango,2);
[N_ind, L_ind] = size(genotipo);
L_var = L_ind/N_var;
potencias = 2.^(0:L_var-1);
for i=1:N_ind
    for j=1:N_var
        fenotipo(i,j) = sum(potencias.*genotipo(i, (j-1)*L_var+1:j*L_var));
    end
end
for i=1:N_var
    fenotipo(:, i) = rango(1, i) + ((rango(2,i)-rango(1,i))/(2^L_var-1))*fenotipo(:,i);
end

end