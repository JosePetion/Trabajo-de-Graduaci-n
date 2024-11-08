function nuevo_gen = xunpunto(nuevo_gen, Pc)
[N_ind, L_ind] = size(nuevo_gen);
auxgen = [];
par = mod(N_ind, 2);

% Para los impares:
for i=1:2:N_ind-1
    cruza = rand;
    if cruza <= Pc
        corte = ceil((L_ind-1)*rand);
        aux_gen(i, :) = [nuevo_gen(i, 1:corte), nuevo_gen(i+1, corte+1:L_ind)];
        aux_gen(i+1,:) = [nuevo_gen(i+1, 1:corte), nuevo_gen(i, corte+1:L_ind)];
    else
        aux_gen(i,:) = nuevo_gen(i,:);
        aux_gen(i+1,:) = nuevo_gen(i+1,:);
    end
end

% Para los pares:
if par == 1
    aux_gen(N_ind, :) = nuevo_gen(N_ind, :);
end
nuevo_gen = aux_gen;
end