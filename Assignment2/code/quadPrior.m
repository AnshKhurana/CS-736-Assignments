function [nlp, grad] = quadPrior(x, gamma)
% Prior term; quadratic penalty
% x: m X n real-valued
% gamma: unused, left for consistency

u = getCliques(x);
nlp = norm(u, 2);
u = reshape(u, [numel(x), numel(u)/numel(x)]);
grad = 2 * sum(u, 2);
grad = reshape(grad, size(x));