function cromTrace(Population)
    for i = 1:size(Population,1)
        crom = Population{i};
        x = crom(:,1);
        y = crom(:,2);
        z = crom(:,3);
        plot3(x, y, z, 'r-o', 'LineWidth', 0.5)
    end
    
end