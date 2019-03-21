function J = costfn(w, q, y, memberships, means, bias, mask)

% J_present = costfn(w, q, y, memberships,  means, bias, mask);
J = 0;
[M, N] = size(y);
for i = 1 : M*N
    for k = 1:K
        J = J + sum((memberships(k)().^q).*((y - memberships(k)*bias).^2));  
    end
end
