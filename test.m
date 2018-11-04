
    
while(true)
      img = snapshot(camera);
    [rows, columns, numberOfColorChannels] = size(img);
    hold on;
    lineSpacing = 20; % Whatever you want.
    stepSize = 20;
    for row = 1 : stepSize : rows
        line([1, columns], [row, row], 'Color', 'r', 'LineWidth', 1);
    end
    for col = 1 : stepSize : columns
        line([col, col], [1, rows], 'Color', 'r', 'LineWidth', 1);
    end
end