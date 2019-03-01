function [ val ] = rrmse( im1, im2 )
% Compute RRMSE

val = norm(im1 - im2, 'fro') / norm(im1, 'fro');
end

