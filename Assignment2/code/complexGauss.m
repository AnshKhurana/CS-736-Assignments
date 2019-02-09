function [nll, grad] = complexGauss(y, x)
% Negative log-likelihood term
% y, x: m X n real-valued

nll = norm(y - x, 'fro');
grad = 2 * (x - y);