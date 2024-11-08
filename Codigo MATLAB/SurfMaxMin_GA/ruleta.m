function nuevo_gen = ruleta(genotipo, fenotipo, aptitud)
[N_ind, aux] = size(aptitud);
total = sum(aptitud);
probabilidad = aptitud/total;
acumulada = cumsum(probabilidad);
for i = 1:N_ind
    selecciona = rand;
    aux = find(acumulada >= selecciona);
    idx(i, 1) = aux(1);
end
nuevo_gen = genotipo(idx, :);
end