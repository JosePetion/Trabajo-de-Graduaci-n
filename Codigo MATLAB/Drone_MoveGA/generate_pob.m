function cromosoma = generate_pob(start, goal, num_points)
    cromosoma = [linspace(start(1), goal(1), num_points)',...
        linspace(start(2), goal(2), num_points)',...
        linspace(start(3), goal(3), num_points)'];
    for i = 2:(num_points-1)
        cromosoma(i,1) = randi([start(1),goal(1)]);
        cromosoma(i,2) = randi([start(2),goal(2)]);
        cromosoma(i,2) = randi([start(3),goal(3)]);
    end
end