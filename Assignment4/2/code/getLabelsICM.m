function [lab, mu, sigma] = getLabelsICM(img, mask, lab, K, mu, sigma, beta)

dim = size(img);
lab_tmp = lab;
objective = 0;
orig_objective = 0;
ICM_maxiter = 8;

for iter = 1:ICM_maxiter
    objective = 0;
    
    for i = 2:dim(1)-1
        for j = 2:dim(2)-1
            if (mask(i, j) == 0)
                continue;
            end
            
            if iter == 1
                comp = lab(i, j);
                orig_prior = getPriorMRF(lab, comp, i, j, mask, beta);
                orig_likelihood = exp(- (1-beta) * (img(i, j) - mu(comp))^2 / (2 * (sigma(comp)^2)));
                orig_objective = orig_objective + orig_prior*orig_likelihood;
%                 start_val = orig_objective;
            end
            
            val = zeros(1, comp);
            for comp = 1:K
                prior = getPriorMRF(lab, comp, i, j, mask, beta);
                likelihood = exp(- (1-beta) * (img(i, j) - mu(comp))^2 / (2 * (sigma(comp)^2)));
                val(comp) = prior*likelihood;
            end
            [maxval, maxind] = max(val);
            objective = objective + maxval;
            lab_tmp(i, j) = maxind;
        end
    end
    
    if objective >= orig_objective
        lab = lab_tmp .* mask;
    else
        break
    end
    
    display(sprintf('ICM log-apost : %d => %d', log(orig_objective), log(objective)));
end
                