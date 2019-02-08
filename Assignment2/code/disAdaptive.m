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

less = (modXl <= gamma);
temp(less) = 0.5 * modXl(less).^2;
temp(~less) = gamma * modXl(~less) - 0.5*gamma*gamma;

val = val + temp;

temp = zeros(size(image));

less = (modXt <= gamma);
temp(less) = 0.5 * modXt(less).^2;
temp(~less) = gamma * modXt(~less) - 0.5*gamma*gamma;

val = val + temp;

temp = zeros(size(image));

less = (modXb <= gamma);
temp(less) = 0.5 * modXb(less).^2;
temp(~less) = gamma * modXb(~less) - 0.5*gamma*gamma;

val = val + temp;

