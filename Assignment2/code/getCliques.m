function [u] = getCliques(x)
% Get cliques of size 2 from image
% x: m X n real-valued

vect = inline('reshape(x, [numel(x), 1])');

u = vect(x - circshift(x, 1, 1));
u = vertcat(u, vect(x - circshift(x, -1, 1)));
u = vertcat(u, vect(x - circshift(x, 1, 2)));
u = vertcat(u, vect(x - circshift(x, -1, 2)));