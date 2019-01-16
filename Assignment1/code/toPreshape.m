function [ out_set ] = toPreshape( in_set )
%TOPRESHAPE Project pointset to preshape space
%   in_set: d X n X s
    
    centroid = mean(in_set, 2);
    out_set = in_set - repmat(centroid, [1, size(in_set, 2), 1]);
    scale_factor = out_set.^2;
    scale_factor = sqrt(sum(sum(scale_factor, 1), 2));
    out_set = out_set ./ repmat(scale_factor, [size(in_set, 1), size(in_set, 2), 1]);
end

