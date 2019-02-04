function [O, logger] = gradientDes(CF, I, grad)
% O - optimum solution, CF - Cost function, I - initial estimate, 
% grad -gradient matrix

s = 0.1; % initial step size
inc_factor = 1.1;
dec_factor = 2;
prev_cost = CF(I);
updated_cost = CF(I);
O = I;
while s > 1e-8 && updated_cost/prev_cost > 1e-4
    logger = [logger, s];
    O = O - s * grad(O);
    updated_cost = CF(O);
    if updated_cost > prev_cost 
        s = s/dec_factor;
        continue;
    else
        s = s*inc_factor;
        prev_cost = updated_cost;
    end
    
    
        
    