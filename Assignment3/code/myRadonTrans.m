function Rf = myRadonTrans(img, t_range, theta_range, ds)

X = size(theta_range, 2);
Y = size(t_range, 2);

Rf = zeros(size(t_range, 2), size(theta_range, 2));


for t = 1:Y
    for th = 1:X
        Rf(t, th) = myIntegration(img, t_range(t), theta_range(th), ds);
    end
end
