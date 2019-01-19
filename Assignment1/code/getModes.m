function [ V, D ] = getModes( in_ps, mean_ps )
%GETMODES Get modes of variation
%   in_ps: d X n X s
%   mean_ps: d x nx
    
    norm_ps = in_ps - repmat(mean_ps, [1, 1, size(in_ps, 3)]);
    norm_ps = reshape(norm_ps, [size(norm_ps, 1) * size(norm_ps, 2), size(norm_ps, 3)]);
    sample_cov = cov(norm_ps');
    
    [V, D] = eig(sample_cov);
    if ~issorted(diag(D))
        [D,I] = sort(diag(D));
        V = V(:, I);
    end
end

