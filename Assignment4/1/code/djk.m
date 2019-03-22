function DJK_matrix  = djk(y, w, mask, mean, bias)
bias = bias .* mask;
DJK_matrix = zeros(size(y));
DJK_matrix = y.*y - 2 .* y .* (conv2(mean.*bias, w, 'same') .*mask) + (conv2((mean * mean).* (bias.^2), w, 'same') .* mask);