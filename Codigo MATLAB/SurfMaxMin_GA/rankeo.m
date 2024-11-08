function aptitud = rankeo(objv, direccion)
SP = 2;
[N_ind, N_obj] = size(objv);
if direccion == 1
    [nuevo_objv, posori] = sort(objv);
    % Obj ordenado, posición original
else
    [nuevo_objv, posori] = sort(-1*objv);
end
apt = 2-SP+2*(SP-1)*((1:N_ind)-1)/(N_ind-1);
aptitud(posori, 1) = apt';
end