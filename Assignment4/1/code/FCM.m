function  [means, bias, memberships, cost_log, bias_removed, residual_image] = FCM(y, q, K, mask, w)

[M, N] = size(y);
data = reshape(y,M*N, 1);
ids = kmeans(data, K);
means = zeros(1,3);
means(1) = mean(data(ids == 1));
means(2) = mean(data(ids == 2));
means(3) = mean(data(ids == 3));
bias = mask;

bias_removed = zeros(M, N);
residual_image = zeros(M, N);
memberships = zeros(M, N, K);


for k = 1:K
     temp = zeros(M, N);
     temp(ids == k) = 1;
     temp = temp .* mask;
     memberships(:, :, k) = temp;
end
J_present = inf;
J_new = costfn(w, q, y, memberships,  means, bias, mask, K);
cost_log = J_present;

rel = 1;
means = [0.2, 0.6, 0.5];
DJ  = zeros(M, N, K);
maxiter = 200;
iter = 1;
while ((iter < maxiter) ) %&& (rel > 1e-9)
    iter = iter +1;
    for k = 1:K   
        DJ(:, :, k) = djk(y, w, mask, means(k), bias);
    end
    sum_DJ = zeros(M, N);
    for k = 1:K
        temp = DJ(:, :,  k);
        temp(temp ~= 0) = (1./temp(temp ~= 0));
        temp(mask ~= 0) = temp(mask ~= 0).^(1/(q-1));
        temp = real(temp);
        sum_DJ = sum_DJ + temp;
    end
    for k = 1:K
        temp =  DJ(:, :, k);
        temp(temp ~= 0) = 1./(temp(temp ~= 0));
        temp(mask ~= 0) = temp(mask ~= 0).^(1/(q-1));
        temp = real(temp);
        temp(mask ~= 0) = temp(mask ~= 0) ./ sum_DJ(mask ~= 0);
        memberships(:, :, k) = temp;
    end
%     disp("Memberships");
%     disp(memberships(:, :, 1));
    for k = 2:K
        convb = conv2(bias,  w, 'same');
        convb2 = conv2(bias.^2, w, 'same');
        t1 = (memberships(:, :, k).^q).*y .* convb;
        t2 = (memberships(:, :, k).^q) .* convb2;
        means(k) =  sum(t1, 'all', 'omitnan')/ sum(t2, 'all', 'omitnan');
    end
    uqck = zeros(size(y));
    uqck2 = zeros(size(y));
    for k = 1:K
        temp =  memberships(:, :, k);
        temp(mask ~= 0)  = (temp(mask~=0) .^q);
        
        uqck = uqck + (means(k).*temp);     
        uqck2 = uqck2 + ((means(k)^2) .*temp);
    end
    
    c1 = conv2(y .* uqck, w, 'same');
    c2 = conv2(uqck2, w, 'same');
    c1 = c1.*mask;
    c2 = c2.*mask;
    bias(mask ~= 0) = c1(mask ~= 0) ./ c2(mask ~= 0);
    J_present = J_new;
    
    cost_log = [cost_log, J_present];


    J_new = costfn(w, q, y, memberships,  means, bias, mask, K);
%     disp(J_new);

    rel = (J_present - J_new)/J_present ;

end

bias_removed = zeros(M, N);
for k = 1:K
    bias_removed = bias_removed + memberships(:, :, k) * means(k);
end

residual_image = y - bias_removed .* bias;


    
    


    