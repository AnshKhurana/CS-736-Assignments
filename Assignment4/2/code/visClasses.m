function [] = visClasses(L, G, beta)
maxval = 1;

% Visualizing labels
img = L * 1 / 3;
figure('Position', [100, 100, 400, 400]), imshow(img);
title(strcat('Labels for \beta=', num2str(beta)));

for i = 1:size(G, 3)
    figure('Position', [100, 100, 400, 400]), imshow(G(:, :, i) * i / size(G, 3));
    title(strcat('Membership for \beta=', num2str(beta), ', class ID=', num2str(i)));
end