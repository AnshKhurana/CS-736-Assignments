function [val, grad] = disAdaptive(image, gamma)

[Xr, Xl, Xb, Xt] = diffNeigh(image);

modXr = abs(Xr);
modXl = abs(Xl);
modXb = abs(Xb);
modXt = abs(Xt);

val = zeros(size(image));
temp = zeros(size(image));

less = (modXr <= gamma);
temp(less) = 0.5 * modXr(less).^2;
temp(~less) = gamma * modXr(~less) - 0.5*gamma*gamma;

val = val + temp;

temp = zeros(size(image));

less = (modXr <= gamma);
temp(less) = 0.5 * modXr(less).^2;
temp(~less) = gamma * modXr(~less) - 0.5*gamma*gamma;

val = val + temp;

temp = zeros(size(image));

less = (modXr <= gamma);
temp(less) = 0.5 * modXr(less).^2;
temp(~less) = gamma * modXr(~less) - 0.5*gamma*gamma;

val = val + temp;

temp = zeros(size(image));

less = (modXr <= gamma);
temp(less) = 0.5 * modXr(less).^2;
temp(~less) = gamma * modXr(~less) - 0.5*gamma*gamma;

val = val + temp;

