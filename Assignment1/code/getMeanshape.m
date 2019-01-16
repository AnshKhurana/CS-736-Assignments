function [ mean_ps, out_ps, logger ] = getMeanshape( in_ps, mean_ps_curr )
%GETMEANSHAPE Compute optimal mean shape from pointset
% in_ps: d X n X s
    
    if nargin < 2
        mean_ps_curr = in_ps(:, :, 1);
    end
    maxiter = 100;
    logger = zeros([maxiter, 1]);
    eps = 10; eps_prev = 10;
    out_ps = in_ps;
    iter = 0;
    
    while (eps/eps_prev > 1e-8) && (eps > 1e-10)
        eps_prev = eps;
        if iter > maxiter
            break
        end
        iter = iter + 1; disp(iter);
        for i = 1:size(in_ps, 3)
            Ri = alignKabsch(in_ps(:, :, i), mean_ps_curr);
            out_ps(:, :, i) = Ri * in_ps(:, :, i);
        end

        mean_ps = toPreshape(mean(out_ps, 3));
        eps = sum(sum((mean_ps - mean_ps_curr).^2));
        logger(iter) = eps;
        mean_ps_curr = mean_ps;
        in_ps = out_ps;
    end
    logger = logger(1:iter);
end

