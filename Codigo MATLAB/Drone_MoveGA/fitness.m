function fit_val = fitness(norm_distances, obs_check)
    fit_val = zeros(size(norm_distances, 1), 1);
    for i = 1:size(norm_distances,1);
            fit_val(i) = 1 / (norm_distances(i)*(obs_check(i)+1));
    end
end