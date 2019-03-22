function J = costfn(w, q, y, memberships, means, bias, mask, K)

% J_present = costfn(w, q, y, memberships,  means, bias, mask);
J = 0;
% imshow(y);
for k = 1:K
    % Have to fix, add convolution operation
    temp = y.*y - 2 .* y .* (conv2(means(k).*bias, w, 'same') .*mask) + (conv2((means(k) * means(k)).* (bias.^2), w, 'same') .* mask);
    temp = temp .* mask;
    c =  sum((memberships(:, :, k).^q).*temp, 'all');
    J = J + c;  
end
