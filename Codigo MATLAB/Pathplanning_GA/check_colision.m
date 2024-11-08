function obs_check = check_colision(obstacleCenter, Pop_size, obstacleRadius, obst_distances)
    obs_check = zeros(Pop_size,size(obstacleCenter, 1));
    for j = 1:size(obstacleCenter, 1)
        n_check = obst_distances{j};
        for i = 1:Pop_size
            if any(n_check(i,:) <= obstacleRadius)
                obs_check(i, j) = true;
            else
                obs_check(i, j) = false;
            end
        end
    end
end