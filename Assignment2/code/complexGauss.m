function [V, G] = complexGauss(Y, X)

d = size(X, 1);
V = 1/pi^d *  exp(- norm(Y- X));
G = 2 * (Y - X);
G = G(:);