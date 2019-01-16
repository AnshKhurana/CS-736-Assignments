function [ R ] = alignKabsch( ps1, ps2 )
%ALIGNKABSCH find optimal rotation matrix to align point set ps1 to
%pointset ps2, using similarity transforms
% ps1, ps2: d X n

    ps1 = squeeze(ps1);
    ps2 = squeeze(ps2);
    
    [U, D, V] = svd(ps1 * ps2');
    
    R = V * U';
    if det(R) < 0
        M = eye(size(V, 2));
        M(end) = -1;
        R = V * M * U';
    end
end

