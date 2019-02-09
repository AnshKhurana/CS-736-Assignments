function [nlp, grad] = adaPrior(x, gamma)
% Prior term; distance-adaptive prior
% x: m X n real-valued
% gamma: scalar

u_org = (getCliques(x));
u = abs(u_org);

loss = gamma*u -(gamma^2)*log(1 + (u/gamma));
nlp = sum(loss);

u = reshape(u, [numel(x), numel(u)/numel(x)]);
u_org = reshape(u_org, [numel(x), numel(u)/numel(x)]);

grad_loss = u_org*gamma ./ (gamma + u);
grad = sum(grad_loss, 2);
grad = reshape(grad, size(x));