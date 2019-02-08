function [X, logger] = gradientAsc(I, noiseModel, prior, alpha, lambda)
% O - optimum solution, CF - Cost function, I - initial estimate, 
% grad -gradient matrix

% Cost is the posterior probabilty

s = 0.1; % initial step size
inc_factor = 1.1;
dec_factor = 2;

X = I;
while s > 1e-8 && updated_cost-prev_cost/prev_cost > 1e-4
    logger = [logger, s];
    X = X - s * grad(X);
    updated_cost = CF(X);
    if updated_cost > prev_cost 
        s = s/dec_factor;
        continue;
    else
        s = s*inc_factor;
        prev_cost = updated_cost;
    end
    
    
        
    