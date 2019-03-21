function  [means, bias, memberships, cost_log, bias_removed, residual_image] = FCM(y, q, K, mask, w)

[M, N] = size(y);
data = reshape(y,M*N, 1);
ids = kmeans(data, K);
means = zeros(1,3);
means(1) = mean(data(ids == 1));
means(2) = mean(data(ids == 2));
means(3) = mean(data(ids == 3));
bias = mask;
disp(means);
bias_removed = zeros(M, N);
residual_image = zeros(M, N)
memberships = zeros(M, N, K);


for k = 1:K
     temp = zeros(M, N);
     temp(ids == k) = 1;
     temp = temp .* mask;
     imshow(temp);
     figure;
     memberships(:, :, k) = temp;
end



J_present = costfn(w, q, y, memberships,  means, bias, mask);
J_new = J_present;
cost_log = [J_present];


DJ  = zeros(M, N, K);
for (J_present > 1e-4) or (J_present - J_new)/J_present < 1e-6) 
    for k = 1:K   
        DJ(:. :, K) = DJK(y, w, mask, means(k), bias);
        temp = (1./DJ(:, :, k)).^q;
        memberships(:, :, k) = temp/sum(temp);
        means(k) =  sum((memberships(:, :, k).^q).*y .* conv2( bias,  w))/ sum(memberships(:, :, k).^q .* conv2(bias.^2, w));
    end
J_present = J_new;
Jnew = costfn(w, q, y, memberships,  means, bias, mask);
cost_log = cost_log = [cost_log; J_new];
end
for k = 1:K
    bias_removed = bias_removed + memberships(k) * means(k);
end
residual_image = y - bias_removed .* bias;


    
    


    