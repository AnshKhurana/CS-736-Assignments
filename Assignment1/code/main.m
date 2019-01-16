clear all; close all;

load('../data/ellipses2D.mat');

in_ps = toPreshape(pointSets);
[mean_ps, out_ps, logger] = getMeanshape(in_ps);

[V, D] = getModes(out_ps, mean_ps);

%% 
for i = 1:300
plot(squeeze(out_ps(1, :, i)), squeeze(out_ps(2, :, i)), '.'); hold on;
end
plot(mean_ps(1, :), mean_ps(2, :), 'LineWidth', 2); hold on;

lambda = D(end);
mode = V(:, end);
mode = reshape(mode, [size(in_ps, 1), size(in_ps, 2)]);
plot(mean_ps(1, :) + (2*sqrt(lambda)*mode(1, :)), mean_ps(2, :) + (2*sqrt(lambda)*mode(2, :)), 'LineWidth', 2); hold on;
plot(mean_ps(1, :) - (2*sqrt(lambda)*mode(1, :)), mean_ps(2, :) - (2*sqrt(lambda)*mode(2, :)), 'LineWidth', 2); hold on;