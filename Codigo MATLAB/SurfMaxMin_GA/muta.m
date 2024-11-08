function nuevo_gen = muta(nuevo_gen, Pm)
[N_ind, L_ind] = size(nuevo_gen);
valores = rand(N_ind, L_ind);
muta = valores <= Pm;
nuevo_gen = xor(nuevo_gen, muta);
end