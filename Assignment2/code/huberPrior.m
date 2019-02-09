function [nlp, grad] = huberPrior(x, gamma)
% Prior term; Huber penalty
% x: m X n real-valued
% gamma: scalar

u_org = getCliques(x);
u = abs(u_org);

loss = (u > gamma).*(gamma*u - 0.5*(gamma^2)) + (~(u > gamma)).*norm(u, 2)*0.5;
nlp = sum(loss);

u = reshape(u, [numel(x), numel(u)/numel(x)]);
u_org = reshape(u_org, [numel(x), numel(u)/numel(x)]);

grad_loss = (u > gamma).*(gamma*sign(u_org)) + (~(u > gamma)).*u_org;
grad = sum(grad_loss, 2);
grad = reshape(grad, size(x));
