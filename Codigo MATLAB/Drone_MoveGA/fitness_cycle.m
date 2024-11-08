function Aptitud = fitness_cycle(cromosoma,...
    pop_size, n_points, obstacleCenter, obstacleRadius)

    dis = euclidian(cromosoma,pop_size,n_points);
    nor = sum(dis, 2);
    ODs = obs_dist(cromosoma,obstacleCenter,n_points);
    chk = check_colision(obstacleCenter, pop_size, obstacleRadius, ODs);
    Aptitud = fitness(nor, chk);
end