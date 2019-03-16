function [lab, gamma] = imageSegEM(img, mask, K, lab, mu, sigma, beta)

dim = size(img);
gamma = zeros(dim(1), dim(2), K);
EM_maxiter = 10;

for iter = 1:EM_maxiter
    % get labels using ICM
    [lab, mu, sigma] = getLabelsICM(img, mask, lab, K, mu, sigma, beta);
    
    for i = 2:dim(1)-1
        for j = 2:dim(2)-1
            if (mask(i, j) == 0)
                continue;
            end
            
            gamma_ij = zeros(1, K);
            for comp = 1:K
                prior = getPriorMRF(lab, comp, i, j, mask, beta);
                likelihood = exp(- (1-beta) * (img(i, j) - mu(comp))^2 / (2 * (sigma(comp)^2)));
                gamma_ij(comp) = prior * likelihood;
            end
            
            gamma_ij = gamma_ij ./ sum(gamma_ij);
            if (sum(isnan(gamma_ij)) == 0)
                gamma(i, j, :) = gamma_ij;
            end
        end
    end
    
    
    for comp = 1:K
        weighted_sum = sum(sum(gamma(:, :, comp) .* img));
        mu(comp) = weighted_sum / sum(sum(gamma(:, :, comp)));
        
        cov = (img - mu(comp)).^2;
        sigma(comp) = sqrt(sum(sum(gamma(:, :, comp) .* cov)) / sum(sum(gamma(:, :, comp))));
    end
end
