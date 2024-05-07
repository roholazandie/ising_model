function radialProfile = computeRadialProfile(data)
    [rows, cols] = size(data);
    centerX = ceil(cols / 2);
    centerY = ceil(rows / 2);
    maxRadius = floor(min([centerX, centerY, cols-centerX, rows-centerY]));
    radialProfile = zeros(1, maxRadius);
    count = zeros(1, maxRadius);
    
    for row = 1:rows
        for col = 1:cols
            radius = floor(sqrt((col - centerX)^2 + (row - centerY)^2));
            if radius < maxRadius
                radialProfile(radius+1) = radialProfile(radius+1) + data(row, col);
                count(radius+1) = count(radius+1) + 1;
            end
        end
    end
    radialProfile = radialProfile ./ count;
end

