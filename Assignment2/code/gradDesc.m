function [x, logger] = gradDesc(img, x, mode, al, lam)
% Gradient descent routine; mode specifies params and objective
% img, x: m X n real-valued
% mode: quadPrior, huberPrior or adaPrior

if strcmp(mode, 'quadPrior')
    alpha = al; % TODO: tune
    gamma = nan;
    getCost = @(x, gamma) quadPrior(x, gamma);
elseif strcmp(mode, 'huberPrior')
    alpha = al; % TODO: tune
    gamma = lam; % tuned
    getCost = @(x, gamma) huberPrior(x, gamma);
elseif strcmp(mode, 'adaPrior')
    alpha = al; % TODO: tune
    gamma = lam; % TODO: tune
    getCost = @(x, gamma) adaPrior(x, gamma);
else
    disp('Error: Unknown params received')
end

step_size = 1e-6;
step_size_thresh = 1e-8;
step_size_inc = 1.1; step_size_dec = 0.5;
max_iter = 1000;
logger = zeros(max_iter, 2);
logger(1, 1) = inf; logger(1, 2) = step_size;

for i = 2:max_iter
    if mod(i, 10) == 0
%         disp(i)
%         disp(step_size)
    end
    
    [nlp, grad_nlp] = getCost(x, gamma);
    [nll, grad_nll] = complexGauss(img, x);
    cost =  alpha*nlp + (1-alpha)*nll;
    grad =  alpha*grad_nlp + (1-alpha)*grad_nll;
    
   
    logger(i, 1) = cost;
    logger(i, 2) = step_size;
    
    if logger(i, 1) >= logger(i-1, 1)
        step_size = step_size * step_size_dec;
    else
        step_size = step_size * step_size_inc;
         x = x - step_size * grad;
    end
    if step_size < step_size_thresh
        break
    end
end

logger = logger(1:i, :);